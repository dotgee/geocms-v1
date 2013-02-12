object @context
attributes :name, :description, :public, :zoom, :center_lng, :center_lat, :uuid

child(:contexts_layers => :layers) do 
  attributes :opacity, :position, :visibility
  glue :layer do
    extends "layers/index"
  end
end
