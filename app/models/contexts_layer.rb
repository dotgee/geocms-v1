class ContextsLayer < ActiveRecord::Base

  belongs_to :context
  belongs_to :layer

  attr_accessible :order, :opacity, :layer_id, :context_id

end
