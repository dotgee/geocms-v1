class Context < ActiveRecord::Base
  acts_as_tenant(:account)
  
  has_and_belongs_to_many :layers
  attr_accessible :maxx, :maxy, :minx, :miny, :name, :zoom, :description, :center_lng, :center_lat, :layer_ids
end
