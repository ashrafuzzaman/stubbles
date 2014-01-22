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

ActiveRecord::Schema.define(version: 20140122121004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "done_by_id"
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "activities", ["done_by_id"], name: "index_activities_on_done_by_id", using: :btree

  create_table "attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "file",            null: false
    t.integer  "uploaded_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", default: "Story"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "milestone_resources", force: true do |t|
    t.integer  "milestone_id"
    t.integer  "resource_id"
    t.float    "available_hours_per_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "milestone_resources", ["milestone_id"], name: "index_milestone_resources_on_milestone_id", using: :btree
  add_index "milestone_resources", ["resource_id"], name: "index_milestone_resources_on_resource_id", using: :btree

  create_table "milestones", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_on"
    t.date     "end_on"
    t.date     "delivered_on"
    t.integer  "duration"
    t.string   "milestone_type"
    t.integer  "project_id"
    t.integer  "parent_milestone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "hours_spent"
    t.float    "hours_estimated"
    t.integer  "percent_completed"
  end

  add_index "milestones", ["parent_milestone_id"], name: "index_milestones_on_parent_milestone_id", using: :btree
  add_index "milestones", ["project_id"], name: "index_milestones_on_project_id", using: :btree

  create_table "project_memberships", force: true do |t|
    t.integer  "project_id",                      null: false
    t.integer  "user_id",                         null: false
    t.string   "role",                            null: false
    t.boolean  "active",           default: true
    t.datetime "last_accessed_at"
  end

  add_index "project_memberships", ["project_id"], name: "index_project_memberships_on_project_id", using: :btree
  add_index "project_memberships", ["user_id"], name: "index_project_memberships_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "sprint_length",         default: 2.0
    t.date     "started_on"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_report_emails"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "stories", force: true do |t|
    t.string   "title"
    t.string   "status"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "assigned_to_id"
    t.integer  "priority"
    t.date     "start_at"
    t.date     "complete_at"
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "milestone_id"
    t.float    "hours_spent"
    t.float    "hours_estimated"
    t.integer  "percent_completed"
    t.integer  "story_type_id"
  end

  add_index "stories", ["assigned_to_id"], name: "index_stories_on_assigned_to_id", using: :btree
  add_index "stories", ["project_id"], name: "index_stories_on_project_id", using: :btree

  create_table "story_types", force: true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_types", ["project_id"], name: "index_story_types_on_project_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.string   "status"
    t.integer  "story_id"
    t.integer  "assigned_to_id"
    t.float    "hours_estimated"
    t.float    "hours_spent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "percent_completed"
    t.integer  "project_id"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["story_id"], name: "index_tasks_on_story_id", using: :btree

  create_table "time_entries", force: true do |t|
    t.float    "hours_spent"
    t.date     "spent_on"
    t.integer  "user_id"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "milestone_id"
    t.integer  "percent_completed"
    t.integer  "percent_completed_on_date"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.date     "date_of_birth"
    t.string   "type"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "version_changes", force: true do |t|
    t.integer "version_id"
    t.string  "field",      null: false
    t.string  "was"
    t.string  "now"
  end

  add_index "version_changes", ["version_id"], name: "index_version_changes_on_version_id", using: :btree

  create_table "versions", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.string   "event",          null: false
    t.integer  "activity_id"
    t.integer  "done_by_id"
    t.integer  "project_id"
    t.datetime "created_at"
  end

  add_index "versions", ["activity_id"], name: "index_versions_on_activity_id", using: :btree
  add_index "versions", ["project_id"], name: "index_versions_on_project_id", using: :btree
  add_index "versions", ["trackable_type", "trackable_id"], name: "index_versions_on_trackable_type_and_trackable_id", using: :btree

  create_table "workflow_statuses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "reserved"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "workflowable_type"
    t.integer  "workflowable_id"
  end

  add_index "workflow_statuses", ["project_id"], name: "index_workflow_statuses_on_project_id", using: :btree

  create_table "workflow_transitions", force: true do |t|
    t.integer  "story_type_id"
    t.string   "event"
    t.integer  "from_status_id"
    t.integer  "to_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_transitions", ["from_status_id"], name: "index_workflow_transitions_on_from_status_id", using: :btree
  add_index "workflow_transitions", ["story_type_id"], name: "index_workflow_transitions_on_story_type_id", using: :btree
  add_index "workflow_transitions", ["to_status_id"], name: "index_workflow_transitions_on_to_status_id", using: :btree

end
