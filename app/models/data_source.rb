class DataSource < ActiveRecord::Base
  has_many :layers
  attr_accessible :csw, :name, :ogc, :wfs, :wms, :rest, :external

  default_scope order("name ASC")

  def import
    wms_client = ROGC::WMSClient.new(self.wms)
    capabilities = wms_client.capabilities
    layers = capabilities.capability.layers

    layers = layers.map do |layer|
      ROGC::LayerPresenter.new(layer)
    end
    layers
  end
end
