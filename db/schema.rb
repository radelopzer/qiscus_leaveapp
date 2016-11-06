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

ActiveRecord::Schema.define(version: 20160926144714) do

  create_table "logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id",          limit: 4,                   null: false
    t.integer "amount_taken",     limit: 4,                   null: false
    t.string  "category",         limit: 15,                  null: false
    t.string  "approval_status",  limit: 11,  default: "new", null: false
    t.string  "message",          limit: 255,                 null: false
    t.date    "leave_start_date",                             null: false
    t.date    "leave_end_date",                               null: false
    t.date    "send_date",                                    null: false
    t.date    "checked_date"
    t.string  "admin_respond",    limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string  "auth_token",      limit: 255,                       null: false
    t.string  "username",        limit: 50,                        null: false
    t.string  "email",           limit: 255,                       null: false
    t.string  "password_digest", limit: 255,                       null: false
    t.integer "role",            limit: 4,   default: 0,           null: false
    t.integer "amount",          limit: 4,   default: 20,          null: false
    t.string  "position",        limit: 255
    t.string  "status",          limit: 10,  default: "available", null: false
    t.string  "avatar",          limit: 255
  end

  add_index "users", ["email"], name: "email", unique: true, using: :btree

end
