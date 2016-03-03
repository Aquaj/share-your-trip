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

ActiveRecord::Schema.define(version: 20160303155834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "experience_id"
    t.integer  "roadmap_id"
    t.date     "planned_on"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "activities", ["experience_id"], name: "index_activities_on_experience_id", using: :btree
  add_index "activities", ["roadmap_id"], name: "index_activities_on_roadmap_id", using: :btree

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "category"
    t.text     "description"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country"
  end

  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "experience_id"
    t.integer  "rating"
    t.text     "review"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ratings", ["experience_id"], name: "index_ratings_on_experience_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "roadmaps", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "start_destination"
    t.string   "end_destination"
    t.integer  "travellers_num"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "roadmaps", ["user_id"], name: "index_roadmaps_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.string   "luggage"
    t.string   "local_mobility"
    t.string   "travel_type"
    t.string   "accomodation_type"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.string   "token"
    t.datetime "token_expiry"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "experience_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "wishlists", ["experience_id"], name: "index_wishlists_on_experience_id", using: :btree
  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id", using: :btree

  add_foreign_key "activities", "experiences"
  add_foreign_key "activities", "roadmaps"
  add_foreign_key "experiences", "users"
  add_foreign_key "ratings", "experiences"
  add_foreign_key "ratings", "users"
  add_foreign_key "roadmaps", "users"
  add_foreign_key "wishlists", "experiences"
  add_foreign_key "wishlists", "users"
end
