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

ActiveRecord::Schema.define(version: 20160406105304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorize_codes", force: :cascade do |t|
    t.text     "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slack_channels", force: :cascade do |t|
    t.string   "slack_channel_id"
    t.string   "name"
    t.boolean  "is_general"
    t.boolean  "is_archived"
    t.boolean  "is_channel"
    t.datetime "created_date"
    t.text     "slack_code"
    t.text     "last_read"
    t.integer  "unread_count"
    t.integer  "slack_team_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "slack_channels", ["slack_channel_id"], name: "index_slack_channels_on_slack_channel_id", using: :btree
  add_index "slack_channels", ["slack_team_id"], name: "index_slack_channels_on_slack_team_id", using: :btree

  create_table "slack_commands", force: :cascade do |t|
    t.text     "response_url"
    t.text     "command"
    t.text     "query"
    t.text     "slack_code"
    t.boolean  "understand"
    t.string   "assigned_to"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "original_token"
    t.string   "original_team_id"
    t.string   "original_team_domain"
    t.string   "original_channel_id"
    t.string   "original_channel_name"
    t.string   "original_user_id"
    t.string   "original_user_name"
    t.string   "original_command"
    t.string   "original_text"
    t.integer  "slack_team_id"
    t.integer  "slack_user_id"
    t.integer  "slack_channel_id"
  end

  add_index "slack_commands", ["slack_channel_id"], name: "index_slack_commands_on_slack_channel_id", using: :btree
  add_index "slack_commands", ["slack_team_id"], name: "index_slack_commands_on_slack_team_id", using: :btree
  add_index "slack_commands", ["slack_user_id"], name: "index_slack_commands_on_slack_user_id", using: :btree

  create_table "slack_task_assignements", force: :cascade do |t|
    t.integer  "slack_task_id"
    t.integer  "slack_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "slack_task_assignements", ["slack_task_id"], name: "index_slack_task_assignements_on_slack_task_id", using: :btree
  add_index "slack_task_assignements", ["slack_user_id"], name: "index_slack_task_assignements_on_slack_user_id", using: :btree

  create_table "slack_tasks", force: :cascade do |t|
    t.integer  "slack_team_id"
    t.integer  "slack_user_id"
    t.integer  "slack_channel_id"
    t.text     "slack_code"
    t.text     "raw_content"
    t.text     "task_description"
    t.text     "response_url"
    t.boolean  "is_done",                default: false
    t.string   "user_creator"
    t.string   "user_assigned"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "channel_order"
    t.datetime "done_date"
    t.integer  "slack_user_assigned_id"
  end

  add_index "slack_tasks", ["slack_channel_id"], name: "index_slack_tasks_on_slack_channel_id", using: :btree
  add_index "slack_tasks", ["slack_team_id"], name: "index_slack_tasks_on_slack_team_id", using: :btree
  add_index "slack_tasks", ["slack_user_id"], name: "index_slack_tasks_on_slack_user_id", using: :btree

  create_table "slack_teams", force: :cascade do |t|
    t.string   "slack_team_id"
    t.string   "team_domain"
    t.string   "company_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "slack_user_channels", force: :cascade do |t|
    t.integer  "slack_user_id"
    t.integer  "slack_channel_id"
    t.datetime "last_update"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "slack_user_channels", ["slack_channel_id"], name: "index_slack_user_channels_on_slack_channel_id", using: :btree
  add_index "slack_user_channels", ["slack_user_id"], name: "index_slack_user_channels_on_slack_user_id", using: :btree

  create_table "slack_users", force: :cascade do |t|
    t.integer  "slack_team_id"
    t.string   "slack_user_id"
    t.string   "name"
    t.string   "email"
    t.string   "color"
    t.boolean  "deleted"
    t.text     "profile"
    t.boolean  "is_admin"
    t.boolean  "is_owner"
    t.boolean  "is_primary_owner"
    t.text     "slack_code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "slack_users", ["slack_team_id"], name: "index_slack_users_on_slack_team_id", using: :btree

  add_foreign_key "slack_channels", "slack_teams"
  add_foreign_key "slack_task_assignements", "slack_tasks"
  add_foreign_key "slack_task_assignements", "slack_users"
  add_foreign_key "slack_tasks", "slack_channels"
  add_foreign_key "slack_tasks", "slack_teams"
  add_foreign_key "slack_tasks", "slack_users"
  add_foreign_key "slack_user_channels", "slack_channels"
  add_foreign_key "slack_user_channels", "slack_users"
  add_foreign_key "slack_users", "slack_teams"
end
