object @layer
attributes :id, :name, :description, :dimension

node :title do |t|
  t.title.humanize
end

child :data_source do
  attributes :wms
end

child :dimensions, :if => lambda { |l| l.dimension? } do
  attributes :value
end