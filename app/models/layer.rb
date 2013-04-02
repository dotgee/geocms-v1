class Layer < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  settings  :analysis => {
              :analyzer => {
                :french_analyzer => {
                  "type"         => "custom",
                  "tokenizer"    => "standard",
                  "filter"       => ["lowercase", "asciifolding", "french_stem", "french_stop", "elision"]
                }
              },
              :filter => {
                :french_stop => {
                  "type" => "stop",
                  "stopwords" => ["_french_"]
                },
                :french_stem  => {
                  "type"     => "stemmer",
                  "name" => "french"
                },
                :elision => {
                  "type" => "elision",
                  "articles" => ["l", "m", "t", "qu", "n", "s", "j", "d"]
                }
              }
            } do
    mapping do
      indexes :id,           :index    => :not_analyzed
      indexes :title,        :analyzer => 'french_analyzer', :boost => 10
      indexes :name,         :analyzer => 'french_analyzer'
      indexes :description,  :analyzer => 'snowball'
    end
  end
  acts_as_taggable_on :keywords

  has_and_belongs_to_many :categories
  belongs_to :data_source
  has_many :contexts_layers, :dependent => :destroy, :uniq => true
  has_many :contexts, :through => :contexts_layers
  has_many :dimensions, :order => 'value ASC'

  store :bbox, accessors: [:minx, :maxx, :miny, :maxy]

  alias_attribute :bounding_box, :bbox


  scope :for_frontend, select(["layers.name", "layers.title", "layers.id", "layers.description",
                       "layers.dimension", "layers.category_id", "data_sources.wms", "layers.metadata_url", "dimensions.value", "category_ids"])
                       .includes(:data_source).includes(:categories).includes(:dimensions)
                       .order(:title).order(:value)


  attr_accessible :description, :name, :title, :wms_url, :data_source_id, :category_ids, :category, :bbox,
                  :crs, :minx, :miny, :maxx, :maxy, :dimension, :template, :remote_thumbnail_url, :metadata_url,
                  :metadata_identifier

  mount_uploader :thumbnail, LayerUploader
  after_save :do_thumbnail


  def can_thumbnail?
    !self.thumb_url.nil?
  end

  def thumb_url(width = 64, height = 64, native_srs="CRS:84")
    box = bbox[native_srs]["table"]["bbox"] unless bbox[native_srs].nil? || bbox[native_srs].empty?
    return '/images/defaultmap.png' if box.nil?
    ROGC::WMSClient.get_map(data_source.wms, name, box, width, height, native_srs)
  end

  def create_dimension_values(values)
    values = values.split(',') unless values.is_a?(Array)

    values.each do |val|
      self.dimensions.create(value: val)
    end
    # self.save
  end

  def short_name
    name.index(":") ? name[name.index(":")+1, name.length] : name
  end

  def minx
    bbox["EPSG:2154"]["table"]["bbox"][0] unless bbox["EPSG:2154"].nil?
  end

  def miny
    bbox["EPSG:2154"]["table"]["bbox"][1] unless bbox["EPSG:2154"].nil?
  end

  def maxx
    bbox["EPSG:2154"]["table"]["bbox"][2] unless bbox["EPSG:2154"].nil?
  end

  def maxy
    bbox["EPSG:2154"]["table"]["bbox"][3] unless bbox["EPSG:2154"].nil?
  end


  def self.as_layer(data_source, category, l)
    layer = Layer.find_or_initialize_by_name(name: l.name, title: l.title, crs: l.crs, minx: l.bbox[0], \
            miny: l.bbox[1], maxx: l.bbox[2], maxy: l.bbox[3], category: category, data_source_id: data_source.id, dimension: 'time') # l.dimension_type)
    if layer.dimension? && layer.is_new?
      Dimension.create_dimensions(layer, l.dimension_values)
    end
    layer.save
  end

  def self.search(params)
    tire.search do
      # TODO: Scope by account
      query { string "title:#{params[:query]}" } if params[:query].present?
    end
  end

  private
    def do_thumbnail
      if self.thumbnail.url.nil?
        self.remote_thumbnail_url = self.thumb_url(64, 64)
        self.save
      end
    end
    # def do_thumbnail
    #   if self.thumbnail.nil?
    #     begin
    #       self.thumbnail = open(self.thumb_url(64, 64)).read
    #       self.save
    #     rescue => e
    #       $stderr.puts "Can't open #{self.thumb_url(1024,1024)}"
    #       $stderr.puts e.inspect
    #     end
    #   end
    # end
end
