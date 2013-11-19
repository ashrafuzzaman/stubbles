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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131113135642) do

  create_table "activities", :force => true do |t|
    t.integer  "done_by_id"
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "activities", ["done_by_id"], :name => "index_activities_on_done_by_id"

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", :default => "Story"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "milestone_resources", :force => true do |t|
    t.integer  "milestone_id"
    t.integer  "resource_id"
    t.float    "available_hours_per_day"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "milestone_resources", ["milestone_id"], :name => "index_milestone_resources_on_milestone_id"
  add_index "milestone_resources", ["resource_id"], :name => "index_milestone_resources_on_resource_id"

  create_table "milestones", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_on"
    t.date     "end_on"
    t.date     "delivered_on"
    t.integer  "duration"
    t.string   "milestone_type"
    t.integer  "project_id"
    t.integer  "parent_milestone_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.float    "hours_spent"
    t.float    "hours_estimated"
    t.integer  "percent_completed"
  end

  add_index "milestones", ["parent_milestone_id"], :name => "index_milestones_on_parent_milestone_id"
  add_index "milestones", ["project_id"], :name => "index_milestones_on_project_id"

  create_table "project_memberships", :force => true do |t|
    t.integer  "project_id",                         :null => false
    t.integer  "user_id",                            :null => false
    t.string   "role",                               :null => false
    t.boolean  "active",           :default => true
    t.datetime "last_accessed_at"
  end

  add_index "project_memberships", ["project_id"], :name => "index_project_memberships_on_project_id"
  add_index "project_memberships", ["user_id"], :name => "index_project_memberships_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "sprint_length", :default => 2.0
    t.date     "started_on"
    t.integer  "creator_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.string   "story_type",        :default => "backlog"
    t.string   "scope",             :default => "backlog"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "assigned_to_id"
    t.integer  "priority"
    t.date     "start_at"
    t.date     "complete_at"
    t.date     "deadline"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "milestone_id"
    t.float    "hours_spent"
    t.float    "hours_estimated"
    t.integer  "percent_completed"
  end

  add_index "stories", ["assigned_to_id"], :name => "index_stories_on_assigned_to_id"
  add_index "stories", ["project_id"], :name => "index_stories_on_project_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.integer  "story_id"
    t.integer  "assigned_to_id"
    t.float    "hours_estimated"
    t.float    "hours_spent"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "percent_completed"
    t.integer  "project_id"
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["story_id"], :name => "index_tasks_on_story_id"

  create_table "time_entries", :force => true do |t|
    t.float    "hours_spent"
    t.date     "spent_on"
    t.integer  "user_id"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "milestone_id"
    t.integer  "percent_completed"
    t.integer  "percent_completed_on_date"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.date     "date_of_birth"
    t.string   "type"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "version_changes", :force => true do |t|
    t.integer "version_id"
    t.string  "field",      :null => false
    t.string  "was"
    t.string  "now"
  end

  add_index "version_changes", ["version_id"], :name => "index_version_changes_on_version_id"

  create_table "versions", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.string   "event",          :null => false
    t.integer  "activity_id"
    t.integer  "done_by_id"
    t.integer  "project_id"
    t.datetime "created_at"
  end

  add_index "versions", ["activity_id"], :name => "index_versions_on_activity_id"
  add_index "versions", ["project_id"], :name => "index_versions_on_project_id"
  add_index "versions", ["trackable_type", "trackable_id"], :name => "index_versions_on_trackable_type_and_trackable_id"

end
