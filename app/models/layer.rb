require "curb"

class Layer < ActiveRecord::Base
  include Concerns::Searchable

  # ELASTICSEARCH MAPPING

  define_mapping do
    indexes :id,           :index    => :not_analyzed
    indexes :title,        :analyzer => 'french_analyzer', :boost => 10
    indexes :name,         :analyzer => 'french_analyzer'
    indexes :description,  :analyzer => 'snowball'
  end

  # RELATIONSHIPS

  belongs_to :data_source
  has_many :contexts_layers,  dependent: :destroy, uniq: true
  has_many :contexts,         through: :contexts_layers
  has_many :dimensions,       order: 'value ASC'
  has_many :bounding_boxes,   dependent: :destroy

  has_and_belongs_to_many :categories

  # SCOPES

  scope :for_frontend, select(
                          ["layers.name", "layers.title", "layers.id", "layers.description",
                            "layers.dimension", "layers.category_id", "data_sources.wms", "layers.metadata_url",
                            "dimensions.value", "category_ids"
                          ]
                        )
                       .includes(:data_source).includes(:categories).includes(:dimensions)
                       .order(:title).order(:value)


  delegate :wms, to: :data_source, prefix: true

  # ATTRIBUTES
  store :bbox, accessors: [:minx, :maxx, :miny, :maxy]

  attr_accessible :description, :name, :title, :wms_url, :data_source_id, :category_ids, :category,
                  :crs, :minx, :miny, :maxx, :maxy, :dimension, :template, :remote_thumbnail_url, :metadata_url,
                  :metadata_identifier

  mount_uploader :thumbnail, LayerUploader
  acts_as_taggable_on :keywords

  # INSTANCE METHODS

  def boundingbox(tenant)
    bbox = bounding_boxes.leafletable.any?      ? bounding_boxes.leafletable.first      :
           bounding_boxes.current(tenant).any?  ? bounding_boxes.current(tenant).first  :
           bounding_boxes.any?                  ? bounding_boxes.first                  :
           nil
    bbox.for_leaflet unless bbox.nil?
  end

  def thumb_url(width = 64, height = 64, native_srs)
    bbox = self.bounding_boxes.first
    box = bbox.to_bbox if bbox
    return '/images/defaultmap.png' if box.nil?
    ROGC::WMSClient.get_map(data_source.wms, name, box, width, height, bbox.crs)
  end

  def do_thumbnail(force=false)
    if force || self.thumbnail.url.nil?
      tempfile = Tempfile.new([ self.id.to_s, '.png' ])
      tempfile.binmode
      begin
       tempfile << Curl.get(self.thumb_url(64, 64, self.crs)).body_str
       tempfile.rewind
       self.thumbnail = tempfile
       # self.remote_thumbnail_url = self.thumb_url(64, 64, self.crs)
       self.save!
      rescue => e
        logger.error e.message
      ensure
       tempfile.close
       tempfile.unlink
      end
    end
  end


end
