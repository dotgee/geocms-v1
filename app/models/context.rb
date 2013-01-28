class Context < ActiveRecord::Base
  acts_as_tenant(:account)
  has_many :contexts_layers
  has_many :layers, :through => :contexts_layers

  attr_accessible :maxx, :maxy, :minx, :miny, :name, :zoom, :description, :center_lng, :center_lat, :layer_ids, :uuid

  before_create :generate_uuid

  def generate_uuid
    str = self.account.subdomain
    str.gsub!("-", "")
    self.uuid = str+"-"+(0...8).map{65.+(rand(26)).chr.downcase}.join
  end

  def bbox
    [minx, miny, maxx, maxy].join(",")
  end
end
