class DataSource < ActiveRecord::Base
  has_many :layers
  attr_accessible :csw, :name, :ogc, :wfs, :wms, :rest

  def import(user)
    catalog = RGeoServer::Catalog.new :user=>user["login"], :url=>rest, :password=>user["password"]
    
    ws = catalog.get_workspace("dotgeocms")
    ds = ws.data_stores.first

    layers = []
    ds.featuretypes.each do |f|
      layers << f
    end
    layers
  end
end
