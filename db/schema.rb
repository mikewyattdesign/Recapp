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

ActiveRecord::Schema.define(version: 20140327150550) do

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignable_id"
    t.string   "assignable_type"
  end

  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "deactivated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_testimonial", default: false
  end

  create_table "event_giveaways", force: true do |t|
    t.integer "event_id"
    t.integer "giveaway_id"
    t.integer "count_given_away"
    t.boolean "wholesaler_or_local_support", default: false
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.integer  "program_id"
    t.boolean  "brand_demo_fit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "digital_engagements",         default: 0
    t.integer  "mileage_impressions",         default: 0
    t.integer  "footprint_impressions",       default: 0
    t.integer  "walk_by_impressions",         default: 0
    t.integer  "total_attendance",            default: 0
    t.text     "note"
    t.boolean  "wholesaler_or_local_support"
    t.string   "city"
    t.string   "state"
    t.string   "street"
    t.string   "postal_code"
    t.string   "country"
    t.integer  "extended_engagements",        default: 0
    t.integer  "estimated_number_of_samples"
    t.decimal  "cost_per_sample"
    t.integer  "tier"
  end

  create_table "events_photos", id: false, force: true do |t|
    t.integer "event_id", null: false
    t.integer "photo_id", null: false
  end

  create_table "giveaways", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "unit_cost",          default: 0.0
    t.boolean  "is_a_sample",        default: false
    t.integer  "samples_per_unit",   default: 0
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "locations", ["event_id"], name: "index_locations_on_event_id"

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "deactivated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   default: 4
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weathers", force: true do |t|
    t.integer  "temperature"
    t.integer  "precipitation"
    t.integer  "wind_chill"
    t.integer  "heat_index"
    t.integer  "wind_speed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "weathers", ["event_id"], name: "index_weathers_on_event_id"

end
