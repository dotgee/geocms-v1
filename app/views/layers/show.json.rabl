object @layer

attributes :id, :name, :description, :time_dimension, :time_dimension_values, :category_ids, :template

node :bbox do |o|
  {
    minx: o.bounding_box[1],
    miny: o.bounding_box[0],
    maxx: o.bounding_box[3],
    maxy: o.bounding_box[2]
  }
end

node :title do |t|
  t.title.humanize
end

child :data_source, :if => lambda { |l| l.respond_to?(:data_source) && l.data_source } do
  attributes :wms
end

child :dimensions, :if => lambda { |l| l.respond_to?(:dimension) && l.dimension?  } do
  attributes :value
end
