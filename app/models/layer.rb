class Layer < ActiveRecord::Base
  belongs_to :category
  belongs_to :data_source
  has_and_belongs_to_many :contexts
  has_many :dimensions

  store :bbox, accessors: [:minx, :maxx, :miny, :maxy]
  attr_accessible :description, :name, :title, :wms_url, :data_source_id, :category_id, :category, :bbox,
                  :crs, :minx, :miny, :maxx, :maxy, :dimension

  def self.as_layer(data_source, category, l)
    layer = Layer.find_or_create_by_name!(name: l.name, title: l.title, crs: l.crs, minx: l.bbox[0], \
            miny: l.bbox[1], maxx: l.bbox[2], maxy: l.bbox[3], category: category, data_source_id: data_source.id, dimension: l.dimension_type)
    layer
  end
end
