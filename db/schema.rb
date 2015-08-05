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

ActiveRecord::Schema.define(version: 20150805144229) do

  create_table "agencies", force: :cascade do |t|
    t.integer  "organisation_id",   limit: 4
    t.string   "organisation_name", limit: 255
    t.string   "address",           limit: 255
    t.string   "website",           limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "judicial_district_agencies", force: :cascade do |t|
    t.integer  "judicial_district_id", limit: 4
    t.integer  "agency_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "judicial_districts", force: :cascade do |t|
    t.string   "short_name", limit: 255
    t.string   "name",       limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "service_methods", force: :cascade do |t|
    t.integer  "agency_id",                        limit: 4
    t.string   "service_method_name",              limit: 255
    t.string   "phone_number",                     limit: 255
    t.string   "phone_extension",                  limit: 255
    t.string   "web_site_url",                     limit: 255
    t.string   "location_address_street_address1", limit: 255
    t.string   "location_address_street_address2", limit: 255
    t.string   "location_address_city",            limit: 255
    t.string   "location_address_state_code",      limit: 255
    t.string   "location_address_postal_code",     limit: 255
    t.string   "location_address_phone_number",    limit: 255
    t.string   "doing_business_as",                limit: 255
    t.string   "location_language_name",           limit: 255
    t.string   "translator_only_flag",             limit: 255
    t.string   "written_material_only_flag",       limit: 255
    t.string   "full_service_flag",                limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "state_code", limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
