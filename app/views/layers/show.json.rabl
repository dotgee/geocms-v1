object @layer

attributes :id, :name, :description, :category_ids, :template, :metadata_url, :metadata_identifier

node :dimension do |o|
  o.respond_to?(:dimension) ? o.dimension : ( o.respond_to?(:time_dimension) && o.time_dimension ? 'time' :  nil )
end

node :dimension_values do |o|
  o.respond_to?(:time_dimension_values) ? o.time_dimension_values : ( o.respond_to?(:dimension_values) ? o.dimension_values :  nil )
end

node :bbox do |o|
  o.bbox
end

node :title do |t|
  t.title.humanize
end

node :default_style, :if => lambda { |o| o.respond_to?(:default_style) } do |l|
  l.default_style
end

node :thumbnail, :if => lambda { |l| l.respond_to?(:thumbnail) } do |l|
  l.thumbnail.url
end

child :data_source, :if => lambda { |l| l.respond_to?(:data_source) && l.data_source } do
  attributes :wms, :wms_version, :ogc, :external
end

child :dimensions, :if => lambda { |l| l.respond_to?(:dimension) && l.dimension?  } do
  attributes :value
end