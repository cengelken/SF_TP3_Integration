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

ActiveRecord::Schema.define(version: 20150901042907) do

  create_table "case_sets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cases", force: :cascade do |t|
    t.string   "case_num"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "case_set_id"
    t.string   "url"
    t.string   "description"
    t.string   "owner"
  end

  add_index "cases", ["case_set_id"], name: "index_cases_on_case_set_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "owner"
    t.text     "next_action"
    t.date     "due_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "case_id"
  end

  add_index "tasks", ["case_id"], name: "index_tasks_on_case_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.string   "refresh_token"
    t.string   "instance_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
