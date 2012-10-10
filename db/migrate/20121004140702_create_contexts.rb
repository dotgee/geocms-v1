class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :name
      t.integer :zoom
      t.float :minx
      t.float :maxx
      t.float :miny
      t.float :maxy
      t.integer :account_id
      t.timestamps
    end
  end
end
