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

ActiveRecord::Schema.define(version: 2018_10_22_152941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "spina_accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "phone"
    t.string "email"
    t.text "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "robots_allowed", default: false
  end

  create_table "spina_attachment_collections", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_attachment_collections_attachments", id: :serial, force: :cascade do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", id: :serial, force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_conference_page_parts", force: :cascade do |t|
    t.bigint "conference_page_id"
    t.string "conference_page_partable_type"
    t.bigint "conference_page_partable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_page_id"], name: "index_spina_conferences_parts_on_page_id"
    t.index ["conference_page_partable_type", "conference_page_partable_id"], name: "index_spina_conferences_parts_on_partable_type_and_partable_id"
  end

  create_table "spina_conferences_conferences", force: :cascade do |t|
    t.daterange "dates"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_spina_conferences_conferences_on_institution_id"
  end

  create_table "spina_conferences_conferences_delegates", id: false, force: :cascade do |t|
    t.bigint "spina_conferences_conference_id", null: false
    t.bigint "spina_conferences_delegate_id", null: false
  end

  create_table "spina_conferences_date_parts", force: :cascade do |t|
    t.date "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_delegates", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.string "url"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_spina_conferences_delegates_on_institution_id"
  end

  create_table "spina_conferences_delegates_dietary_requirements", id: false, force: :cascade do |t|
    t.bigint "spina_conferences_delegate_id", null: false
    t.bigint "spina_conferences_dietary_requirement_id", null: false
  end

  create_table "spina_conferences_delegates_presentations", id: false, force: :cascade do |t|
    t.bigint "spina_conferences_delegate_id", null: false
    t.bigint "spina_conferences_presentation_id", null: false
  end

  create_table "spina_conferences_dietary_requirements", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_email_address_parts", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_institutions", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "logo_id"
    t.index ["logo_id"], name: "index_spina_conferences_institutions_on_logo_id"
  end

  create_table "spina_conferences_presentation_types", force: :cascade do |t|
    t.string "name"
    t.interval "duration"
    t.bigint "conference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_spina_conferences_presentation_types_on_conference_id"
  end

  create_table "spina_conferences_presentations", force: :cascade do |t|
    t.string "title"
    t.text "abstract"
    t.bigint "room_use_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_datetime"
    t.index ["room_use_id"], name: "index_spina_conferences_presentations_on_room_use_id"
  end

  create_table "spina_conferences_room_possessions", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "conference_id"
    t.index ["conference_id"], name: "index_spina_conferences_room_possessions_on_conference_id"
    t.index ["room_id"], name: "index_spina_conferences_room_possessions_on_room_id"
  end

  create_table "spina_conferences_room_uses", force: :cascade do |t|
    t.bigint "room_possession_id"
    t.bigint "presentation_type_id"
    t.index ["presentation_type_id"], name: "index_spina_conferences_room_uses_on_presentation_type_id"
    t.index ["room_possession_id"], name: "index_spina_conferences_room_uses_on_room_possession_id"
  end

  create_table "spina_conferences_rooms", force: :cascade do |t|
    t.string "number"
    t.string "building"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_spina_conferences_rooms_on_institution_id"
  end

  create_table "spina_conferences_time_parts", force: :cascade do |t|
    t.datetime "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_url_parts", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_image_collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_image_collections_images", id: :serial, force: :cascade do |t|
    t.integer "image_collection_id"
    t.integer "image_id"
    t.integer "position"
    t.index ["image_collection_id"], name: "index_spina_image_collections_images_on_image_collection_id"
    t.index ["image_id"], name: "index_spina_image_collections_images_on_image_id"
  end

  create_table "spina_images", force: :cascade do |t|
    t.integer "media_folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_folder_id"], name: "index_spina_images_on_media_folder_id"
  end

  create_table "spina_layout_parts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.integer "layout_partable_id"
    t.string "layout_partable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "account_id"
  end

  create_table "spina_line_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_line_id", null: false
    t.string "locale", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_spina_line_translations_on_locale"
    t.index ["spina_line_id"], name: "index_spina_line_translations_on_spina_line_id"
  end

  create_table "spina_lines", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_media_folders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_navigation_items", id: :serial, force: :cascade do |t|
    t.integer "page_id", null: false
    t.integer "navigation_id", null: false
    t.integer "position", default: 0, null: false
    t.string "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id", "navigation_id"], name: "index_spina_navigation_items_on_page_id_and_navigation_id", unique: true
  end

  create_table "spina_navigations", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.boolean "auto_add_pages", default: false, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_spina_navigations_on_name", unique: true
  end

  create_table "spina_options", id: :serial, force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_page_parts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page_id"
    t.integer "page_partable_id"
    t.string "page_partable_type"
  end

  create_table "spina_page_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_page_id", null: false
    t.string "locale", null: false
    t.string "title"
    t.string "menu_title"
    t.string "description"
    t.string "seo_title"
    t.string "materialized_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_spina_page_translations_on_locale"
    t.index ["spina_page_id"], name: "index_spina_page_translations_on_spina_page_id"
  end

  create_table "spina_pages", id: :serial, force: :cascade do |t|
    t.boolean "show_in_menu", default: true
    t.string "slug"
    t.boolean "deletable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "skip_to_first_child", default: false
    t.string "view_template"
    t.string "layout_template"
    t.boolean "draft", default: false
    t.string "link_url"
    t.string "ancestry"
    t.integer "position"
    t.boolean "active", default: true
    t.integer "resource_id"
    t.string "type"
    t.index ["resource_id"], name: "index_spina_pages_on_resource_id"
  end

  create_table "spina_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "label"
    t.string "view_template"
    t.integer "parent_page_id"
    t.string "order_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_page_id"], name: "index_spina_resources_on_parent_page_id"
  end

  create_table "spina_rewrite_rules", id: :serial, force: :cascade do |t|
    t.string "old_path"
    t.string "new_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_settings", id: :serial, force: :cascade do |t|
    t.string "plugin"
    t.jsonb "preferences", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plugin"], name: "index_spina_settings_on_plugin"
  end

  create_table "spina_structure_items", id: :serial, force: :cascade do |t|
    t.integer "structure_id"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id"
  end

  create_table "spina_structure_parts", id: :serial, force: :cascade do |t|
    t.integer "structure_item_id"
    t.integer "structure_partable_id"
    t.string "structure_partable_type"
    t.string "name"
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id"
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id"
  end

  create_table "spina_structures", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_text_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_text_id", null: false
    t.string "locale", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_spina_text_translations_on_locale"
    t.index ["spina_text_id"], name: "index_spina_text_translations_on_spina_text_id"
  end

  create_table "spina_texts", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_logged_in"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_foreign_key "spina_conferences_conference_page_parts", "spina_pages", column: "conference_page_id", on_delete: :cascade
  add_foreign_key "spina_conferences_conferences", "spina_conferences_institutions", column: "institution_id", on_delete: :cascade
  add_foreign_key "spina_conferences_delegates", "spina_conferences_institutions", column: "institution_id", on_delete: :cascade
  add_foreign_key "spina_conferences_institutions", "spina_images", column: "logo_id", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_types", "spina_conferences_conferences", column: "conference_id", on_delete: :cascade
  add_foreign_key "spina_conferences_presentations", "spina_conferences_room_uses", column: "room_use_id", on_delete: :cascade
  add_foreign_key "spina_conferences_room_possessions", "spina_conferences_conferences", column: "conference_id", on_delete: :cascade
  add_foreign_key "spina_conferences_room_possessions", "spina_conferences_rooms", column: "room_id", on_delete: :cascade
  add_foreign_key "spina_conferences_room_uses", "spina_conferences_presentation_types", column: "presentation_type_id", on_delete: :cascade
  add_foreign_key "spina_conferences_room_uses", "spina_conferences_room_possessions", column: "room_possession_id", on_delete: :cascade
  add_foreign_key "spina_conferences_rooms", "spina_conferences_institutions", column: "institution_id", on_delete: :cascade
end
