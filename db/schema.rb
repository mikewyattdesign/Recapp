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

ActiveRecord::Schema.define(version: 20150908163828) do

  create_table "api_keys", force: true do |t|
    t.string   "name"
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_testimonial",   default: false
    t.integer  "comment_type",     default: 1
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.boolean  "event_favorite",   default: false, null: false
    t.boolean  "program_favorite", default: false, null: false
    t.boolean  "brand_favorite",   default: false, null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "mobile_phone"
    t.string   "desk_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts_events", force: true do |t|
    t.integer "event_id"
    t.integer "contact_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "documents", force: true do |t|
    t.integer  "documentable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.string   "documentable_type"
  end

  add_index "documents", ["documentable_id"], name: "index_documents_on_documentable_id"

  create_table "event_favorite_photos", force: true do |t|
    t.integer "event_id"
    t.integer "photo_id"
    t.integer "order"
  end

  create_table "event_giveaways", force: true do |t|
    t.integer "event_id"
    t.integer "giveaway_id"
    t.integer "count_given_away"
    t.boolean "wholesaler_or_local_support", default: false
    t.integer "event_favorite",              default: 0
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.integer  "program_id"
    t.boolean  "brand_demo_fit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "digital_engagements",         default: 0, null: false
    t.integer  "mileage_impressions",         default: 0, null: false
    t.integer  "footprint_impressions",       default: 0, null: false
    t.integer  "walk_by_impressions",         default: 0, null: false
    t.integer  "total_attendance",            default: 0, null: false
    t.text     "note"
    t.boolean  "wholesaler_or_local_support"
    t.string   "city"
    t.string   "state"
    t.string   "street"
    t.string   "postal_code"
    t.integer  "extended_engagements",        default: 0, null: false
    t.integer  "estimated_number_of_samples"
    t.decimal  "cost_per_sample"
    t.integer  "tier"
    t.text     "overview"
    t.string   "kpis"
    t.string   "venue"
    t.string   "suite"
    t.datetime "completed_at"
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
    t.integer  "starting_inventory", default: 0
  end

  create_table "links", force: true do |t|
    t.string   "url"
    t.integer  "linkable_id"
    t.string   "linkable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "processed",          default: false, null: false
    t.string   "direct_upload_url"
    t.boolean  "event_favorite",     default: false
    t.boolean  "program_favorite",   default: false
    t.boolean  "brand_favorite",     default: false
  end

  add_index "photos", ["imageable_id"], name: "index_photos_on_imageable_id"
  add_index "photos", ["imageable_type"], name: "index_photos_on_imageable_type"
  add_index "photos", ["processed"], name: "index_photos_on_processed"

  create_table "programs", force: true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "deactivated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "overview"
  end

  create_table "reports", force: true do |t|
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.string   "report_file_name"
    t.string   "report_content_type"
    t.integer  "report_file_size"
    t.datetime "report_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["reportable_id", "reportable_type"], name: "index_reports_on_reportable_id_and_reportable_type"

  create_table "requests", force: true do |t|
    t.integer  "requestor_id"
    t.integer  "requestable_id"
    t.string   "requestable_type"
    t.integer  "request_type"
    t.boolean  "complete",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["requestable_id", "requestable_type"], name: "index_requests_on_requestable_id_and_requestable_type"
  add_index "requests", ["requestor_id"], name: "index_requests_on_requestor_id"

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
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
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
    t.integer  "role",                   default: -1
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "videos", force: true do |t|
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "videos", ["event_id"], name: "index_videos_on_event_id"

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
