object @layer
attributes :id, :name, :description

node :title do |t|
  t.title.humanize
end

child :data_source do
  attributes :wms
end