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

ActiveRecord::Schema.define(version: 20170207184607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "size"
    t.string   "color"
    t.string   "category"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_items_on_user_id", using: :btree
  end

  create_table "requesters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "item_id"
    t.index ["item_id"], name: "index_requesters_on_item_id", using: :btree
    t.index ["user_id"], name: "index_requesters_on_user_id", using: :btree
  end

  create_table "selectors", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "requester_id"
    t.integer  "user_id"
    t.integer  "item_id"
    t.index ["item_id"], name: "index_selectors_on_item_id", using: :btree
    t.index ["requester_id"], name: "index_selectors_on_requester_id", using: :btree
    t.index ["user_id"], name: "index_selectors_on_user_id", using: :btree
  end

  create_table "swaps", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "requester_id"
    t.integer  "selector_id"
    t.string   "status",       default: "pending"
    t.index ["requester_id"], name: "index_swaps_on_requester_id", using: :btree
    t.index ["selector_id"], name: "index_swaps_on_selector_id", using: :btree
  end

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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "items", "users"
  add_foreign_key "requesters", "items"
  add_foreign_key "requesters", "users"
  add_foreign_key "selectors", "items"
  add_foreign_key "selectors", "requesters"
  add_foreign_key "selectors", "users"
  add_foreign_key "swaps", "requesters"
  add_foreign_key "swaps", "selectors"
end
