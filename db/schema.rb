# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121025081021) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "ancestry"
    t.string   "names_depth_cache"
    t.integer  "account_id"
    t.boolean  "default"
    t.string   "slug"
  end

  add_index "categories", ["account_id", "slug"], :name => "index_categories_on_account_id_and_slug", :unique => true
  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "contexts", :force => true do |t|
    t.string   "name",        :default => "Untitled map"
    t.text     "description"
    t.boolean  "public",      :default => false
    t.integer  "zoom",        :default => 10
    t.float    "minx"
    t.float    "maxx"
    t.float    "miny"
    t.float    "maxy"
    t.string   "uuid"
    t.float    "center_lng",  :default => -1.676235
    t.float    "center_lat",  :default => 48.118454
    t.integer  "account_id",                              :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "contexts", ["uuid"], :name => "index_contexts_on_uuid", :unique => true

  create_table "contexts_layers", :id => false, :force => true do |t|
    t.integer "context_id"
    t.integer "layer_id"
  end

  add_index "contexts_layers", ["context_id", "layer_id"], :name => "index_contexts_layers_on_context_id_and_layer_id"

  create_table "data_sources", :force => true do |t|
    t.string   "name"
    t.string   "wms"
    t.string   "wfs"
    t.string   "csw"
    t.string   "ogc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "rest"
  end

  create_table "dimensions", :force => true do |t|
    t.string   "value"
    t.integer  "layer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "layers", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "category_id"
    t.integer  "data_source_id"
    t.text     "bbox"
    t.string   "crs"
    t.string   "dimension"
  end

  create_table "preferences", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email",            :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "account_id"
  end

end
