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

ActiveRecord::Schema.define(:version => 20130801012023) do

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

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "job_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "external_category_id"
  end

  create_table "job_subcategories", :force => true do |t|
    t.string   "name"
    t.integer  "job_category_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "job_subcategories_jobs", :force => true do |t|
    t.integer "job_subcategory_id"
    t.integer "job_id"
  end

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.integer  "address_id"
    t.datetime "posted_at"
    t.datetime "expires_at"
    t.string   "job_type"
    t.integer  "company_id"
    t.string   "external_job_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "description"
    t.string   "source"
  end

end
