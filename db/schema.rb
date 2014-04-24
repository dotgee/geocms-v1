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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131119112712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "logo"
    t.boolean  "default",    default: false
  end

  create_table "bounding_boxes", force: true do |t|
    t.string   "crs"
    t.float    "minx"
    t.float    "miny"
    t.float    "maxx"
    t.float    "maxy"
    t.integer  "layer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bounding_boxes", ["layer_id"], name: "index_bounding_boxes_on_layer_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "ancestry"
    t.string   "names_depth_cache"
    t.integer  "account_id"
    t.string   "slug"
    t.integer  "ancestry_depth",    default: 0
  end

  add_index "categories", ["account_id", "slug"], name: "index_categories_on_account_id_and_slug", unique: true, using: :btree
  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree

  create_table "categories_layers", id: false, force: true do |t|
    t.integer "layer_id"
    t.integer "category_id"
  end

  add_index "categories_layers", ["layer_id", "category_id"], name: "index_categories_layers_on_layer_id_and_category_id", using: :btree

  create_table "contexts", force: true do |t|
    t.string   "name",        default: ""
    t.text     "description"
    t.boolean  "public",      default: false
    t.integer  "zoom",        default: 10
    t.float    "minx"
    t.float    "maxx"
    t.float    "miny"
    t.float    "maxy"
    t.string   "uuid"
    t.float    "center_lng",  default: -1.676235
    t.float    "center_lat",  default: 48.118454
    t.integer  "account_id",                      null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "preview"
  end

  add_index "contexts", ["account_id"], name: "index_contexts_on_account_id", using: :btree
  add_index "contexts", ["uuid"], name: "index_contexts_on_uuid", unique: true, using: :btree

  create_table "contexts_layers", force: true do |t|
    t.integer "context_id"
    t.integer "layer_id"
    t.integer "position"
    t.integer "opacity"
    t.boolean "visibility", default: true
  end

  add_index "contexts_layers", ["context_id", "layer_id"], name: "index_contexts_layers_on_context_id_and_layer_id", using: :btree

  create_table "data_sources", force: true do |t|
    t.string   "name"
    t.string   "wms"
    t.string   "wfs"
    t.string   "csw"
    t.string   "ogc"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "rest"
    t.string   "wms_version",  default: "1.1.1"
    t.boolean  "not_internal", default: true
  end

  create_table "dimensions", force: true do |t|
    t.string   "value"
    t.integer  "layer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dimensions", ["layer_id"], name: "index_dimensions_on_layer_id", using: :btree

  create_table "geometry_columns", id: false, force: true do |t|
    t.string  "f_table_catalog",   limit: 256, null: false
    t.string  "f_table_schema",    limit: 256, null: false
    t.string  "f_table_name",      limit: 256, null: false
    t.string  "f_geometry_column", limit: 256, null: false
    t.integer "coord_dimension",               null: false
    t.integer "srid",                          null: false
    t.string  "type",              limit: 30,  null: false
  end

  create_table "layers", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "data_source_id"
    t.text     "bbox"
    t.string   "crs"
    t.string   "dimension"
    t.text     "template"
    t.string   "default_style"
    t.string   "thumbnail"
    t.string   "metadata_url"
    t.string   "metadata_identifier"
    t.string   "slug"
    t.boolean  "tiled",               default: false
  end

  add_index "layers", ["data_source_id"], name: "index_layers_on_data_source_id", using: :btree
  add_index "layers", ["slug"], name: "index_layers_on_slug", unique: true, using: :btree

  create_table "memberships", force: true do |t|
    t.integer "account_id"
    t.integer "user_id"
  end

  add_index "memberships", ["account_id", "user_id"], name: "index_memberships_on_account_id_and_user_id", using: :btree

  create_table "preferences", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "preferences", ["account_id"], name: "index_preferences_on_account_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "spatial_ref_sys", id: false, force: true do |t|
    t.integer "srid",                   null: false
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "username",         null: false
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_md5"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
