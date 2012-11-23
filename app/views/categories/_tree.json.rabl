object @category
attributes :name, :id

child(:layers, :unless => lambda { |c| c.layers.empty? }) do
 extends "layers/index"
end

child :children => :children do
  extends "categories/index"
end
