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

ActiveRecord::Schema.define(version: 2018_07_05_222640) do

  create_table "spina_conferences", force: :cascade do |t|
    t.date "start_date"
    t.date "finish_date"
    t.string "city"
    t.string "institution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_delegates", id: false, force: :cascade do |t|
    t.integer "spina_delegate_id", null: false
    t.integer "spina_conference_id", null: false
  end

  create_table "spina_delegates", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.string "institution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_presentations", force: :cascade do |t|
    t.string "title"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.text "abstract"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "spina_conference_id"
    t.index ["spina_conference_id"], name: "index_spina_presentations_on_spina_conference_id"
  end

end
