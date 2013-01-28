class ContextsLayer < ActiveRecord::Base

  belongs_to :context
  belongs_to :layer

  default_scope order("position asc")

  attr_accessible :position, :opacity, :layer_id, :context_id

end
