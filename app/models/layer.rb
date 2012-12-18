class Layer < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,           :index    => :not_analyzed
    indexes :title,        :analyzer => 'snowball', :boost => 100
    indexes :name,         :analyzer => 'snowball'
    indexes :description,  :analyzer => 'snowball'
  end

  belongs_to :category
  belongs_to :data_source
  has_and_belongs_to_many :contexts
  has_many :dimensions

  store :bbox, accessors: [:minx, :maxx, :miny, :maxy]


  scope :for_frontend, select(["layers.name", "layers.title", "layers.id", "layers.description",
                       "layers.dimension", "layers.category_id", "data_sources.wms", "dimensions.value"])
                       .includes(:data_source)
                       .order(:title)


  attr_accessible :description, :name, :title, :wms_url, :data_source_id, :category_id, :category, :bbox,
                  :crs, :minx, :miny, :maxx, :maxy, :dimension

  def self.as_layer(data_source, category, l)
    layer = Layer.find_or_initialize_by_name(name: l.name, title: l.title, crs: l.crs, minx: l.bbox[0], \
            miny: l.bbox[1], maxx: l.bbox[2], maxy: l.bbox[3], category: category, data_source_id: data_source.id, dimension: l.dimension_type)
    if layer.dimension? && layer.is_new?
      Dimension.create_dimensions(layer, l.dimension_values)
    end
    layer.save
  end


  def self.search(params)
    tire.search do
      # TODO: Scope by account
      query { string params[:query] } if params[:query].present?
    end
  end

end