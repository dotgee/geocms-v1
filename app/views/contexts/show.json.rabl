object @context
attributes :name, :description, :public, :zoom, :center_lng, :center_lat, :uuid

child(:contexts_layers => :layers) do 
  attribute :opacity
  glue :layer do
    extends "layers/index"
  end
end
