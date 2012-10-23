class Dimension < ActiveRecord::Base
  belongs_to :layer

  attr_accessible :layer_id, :value

  def self.create_dimensions(layer, values)
    vals = values.split(",")
    vals.each do |v|
      Dimension.create!(layer_id: layer.id, value: v)
    end
  end

end
