class Dimension < ActiveRecord::Base
  belongs_to :layer

  attr_accessible :layer_id, :value

  validates :layer_id, presence: true
  validates :value, uniqueness: { scope: :layer_id }

  def self.create_dimensions(layer, values)
    values = values.split(",") unless values.is_a?(Array)

    values.each do |v|
      Dimension.create!(layer_id: layer.id, value: v)
    end
  end

end
