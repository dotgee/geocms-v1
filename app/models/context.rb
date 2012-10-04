class Context < ActiveRecord::Base
  acts_as_tenant(:account)
  
  has_many :layers
  attr_accessible :maxx, :maxy, :minx, :miny, :name, :zoom
end
