object @layer
cache @layer

attributes :id, :name, :description, :dimension, :category_ids, :bbox

node :title do |t|
  t.title.humanize
end

child :data_source, :if => lambda { |l| l.respond_to?(:data_source) && l.data_source } do
  attributes :wms
end

child :dimensions, :if => lambda { |l| l.respond_to?(:dimension) && l.dimension?  } do
  attributes :value
end
