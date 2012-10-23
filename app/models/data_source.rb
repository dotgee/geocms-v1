class DataSource < ActiveRecord::Base
  has_many :layers
  attr_accessible :csw, :name, :ogc, :wfs, :wms, :rest

  def import
    geoserver = WmsGetcapabilities::Geoserver.new(self.wms)
    geoserver.get_capabilities
    layers = geoserver.layers

    layers.each do |l|
      layer = Layer.as_layer(self, l)
      if layer.dimension?
        Dimension.create_dimensions(layer, l.dimension_values)
      end
    end
    layers
  end
end
