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

ActiveRecord::Schema.define(version: 20130727160829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "actuals", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "origin_latitude"
    t.decimal  "origin_longitude"
    t.decimal  "destination_latitude"
    t.decimal  "destination_longitude"
    t.integer  "miles"
    t.integer  "direct_miles"
    t.spatial  "origin",                limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.spatial  "destination",           limit: {:srid=>4326, :type=>"point", :geographic=>true}
  end

  add_index "actuals", ["destination"], :name => "destination_index", :spatial => true
  add_index "actuals", ["destination_latitude"], :name => "index_actuals_on_destination_latitude"
  add_index "actuals", ["destination_longitude"], :name => "index_actuals_on_destination_longitude"
  add_index "actuals", ["direct_miles"], :name => "index_actuals_on_direct_miles"
  add_index "actuals", ["origin"], :name => "origin_index", :spatial => true
  add_index "actuals", ["origin_latitude"], :name => "index_actuals_on_origin_latitude"
  add_index "actuals", ["origin_longitude"], :name => "index_actuals_on_origin_longitude"

  create_table "estimates", force: true do |t|
    t.decimal  "origin_latitude"
    t.decimal  "origin_longitude"
    t.decimal  "destination_latitude"
    t.decimal  "destination_longitude"
    t.integer  "miles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
