class AddPrimaryKeyToLayersContext < ActiveRecord::Migration
  def change
    add_column :contexts_layers, :id, :primary_key
  end
end
