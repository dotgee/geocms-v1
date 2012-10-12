object @context
attributes :name, :description, :public, :zoom, :center_lng, :center_lat, :slug

child :layers do
 extends "layers/index"
end