object @category
attributes :name, :position, :parent_id, :id

child :layers do
 extends "layers/index"
end