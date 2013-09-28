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

ActiveRecord::Schema.define(:version => 20130927054409) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.integer  "postcode"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "candidate_search_beta_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "candidates", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "status"
    t.string   "job_title"
    t.integer  "address_id"
    t.string   "visa"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "minimum_annual_salary"
    t.integer  "user_id"
    t.string   "profile_photo"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "logo_url"
  end

  create_table "contact_forms", :force => true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "about"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "favourites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "job_applications", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "resume"
    t.integer  "user_id"
    t.integer  "job_id"
    t.boolean  "accepted_terms"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "cover_letter"
  end

  create_table "job_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "external_category_id"
    t.string   "slug"
    t.text     "external_category_ids"
  end

  add_index "job_categories", ["slug"], :name => "index_job_categories_on_slug", :unique => true

  create_table "job_subcategories", :force => true do |t|
    t.string   "name"
    t.integer  "job_category_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "external_subcategory_id"
    t.string   "slug"
    t.text     "external_subcategory_ids"
  end

  create_table "job_subcategories_jobs", :force => true do |t|
    t.integer "job_subcategory_id"
    t.integer "job_id"
  end

  add_index "job_subcategories_jobs", ["job_id"], :name => "index_job_subcategories_jobs_on_job_id"
  add_index "job_subcategories_jobs", ["job_subcategory_id"], :name => "index_job_subcategories_jobs_on_job_subcategory_id"

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.integer  "address_id"
    t.datetime "posted_at"
    t.datetime "expires_at"
    t.string   "job_type"
    t.integer  "company_id"
    t.string   "external_job_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "description"
    t.string   "source"
    t.string   "slug"
    t.string   "external_apply_url"
    t.tsvector "tsv"
  end

  add_index "jobs", ["address_id"], :name => "index_jobs_on_address_id"
  add_index "jobs", ["company_id"], :name => "index_jobs_on_company_id"
  add_index "jobs", ["slug"], :name => "index_jobs_on_slug", :unique => true

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.string   "email_frequency", :default => "Daily"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.date     "next_alert_date"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "recent_searches", :force => true do |t|
    t.string   "job_title"
    t.string   "address"
    t.string   "days"
    t.string   "sort"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "search_at"
    t.text     "source"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "subscribed",     :default => false
    t.text     "search_results"
  end

  add_index "recent_searches", ["user_id"], :name => "index_recent_searches_on_user_id"

  create_table "referral_sites", :force => true do |t|
    t.string   "name"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resumes", :force => true do |t|
    t.integer  "candidate_id"
    t.text     "courses"
    t.text     "awards"
    t.text     "skills"
    t.text     "objective"
    t.text     "summary"
    t.string   "other"
    t.string   "citizenship"
    t.text     "affiliations"
    t.text     "professional"
    t.text     "interests"
    t.text     "referees"
    t.datetime "updated_at_linkme"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
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

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
