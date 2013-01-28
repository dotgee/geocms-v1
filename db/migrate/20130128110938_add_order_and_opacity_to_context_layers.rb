class AddOrderAndOpacityToContextLayers < ActiveRecord::Migration
  def change
    add_column :contexts_layers, :order, :integer
    add_column :contexts_layers, :opacity, :integer
  end
end
