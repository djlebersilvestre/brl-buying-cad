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

ActiveRecord::Schema.define(version: 20150313133927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_houses", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "exchange_houses", ["name"], name: "index_exchange_houses_on_name", unique: true, using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "exchange_house_id", null: false
    t.datetime "created_at",        null: false
    t.float    "value",             null: false
  end

  add_index "rates", ["exchange_house_id", "created_at"], name: "index_rates_on_exchange_house_id_and_created_at", unique: true, using: :btree
  add_index "rates", ["exchange_house_id"], name: "index_rates_on_exchange_house_id", using: :btree

  add_foreign_key "rates", "exchange_houses"
end
