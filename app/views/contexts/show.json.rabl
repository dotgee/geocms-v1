object @context
attributes :name, :description, :public, :zoom, :center_lng, :center_lat, :uuid

child(:layers, :unless => lambda { |m| m.layers.empty? }) do
 extends "layers/index"
end
