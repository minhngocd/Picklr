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

ActiveRecord::Schema.define(version: 20140708162032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "environments_repositories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "environments_repositories", ["name"], name: "index_environments_repositories_on_name", unique: true, using: :btree

  create_table "environments_repositories_toggles_repositories", id: false, force: true do |t|
    t.integer "toggles_repository_id",      null: false
    t.integer "environments_repository_id", null: false
    t.boolean "value"
  end

  add_index "environments_repositories_toggles_repositories", ["toggles_repository_id", "environments_repository_id"], name: "toggle_value_index", using: :btree

  create_table "toggles_repositories", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "toggles_repositories", ["name"], name: "index_toggles_repositories_on_name", unique: true, using: :btree

end
