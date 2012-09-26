class DataSource < ActiveRecord::Base
  has_many :layers
  attr_accessible :csw, :name, :ogc, :wfs, :wms
end
