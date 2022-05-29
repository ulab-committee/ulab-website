# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_01_31_170730) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
    t.index ["record_type", "record_id", "name", "locale"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "record"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "record"
  end

  create_table "spina_accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "phone"
    t.string "email"
    t.text "preferences"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "robots_allowed", default: false
    t.jsonb "json_attributes"
  end

  create_table "spina_admin_journal_affiliations", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "surname", null: false
    t.integer "status", default: 0, null: false
    t.integer "institution_id", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_spina_admin_journal_affiliations_on_author_id"
    t.index ["institution_id"], name: "index_spina_admin_journal_affiliations_on_institution_id"
  end

  create_table "spina_admin_journal_articles", force: :cascade do |t|
    t.integer "number", default: 0, null: false
    t.string "title", null: false
    t.string "url", default: "", null: false
    t.string "doi", default: "", null: false
    t.integer "issue_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "json_attributes"
    t.integer "status", default: 0, null: false
    t.bigint "licence_id"
    t.index ["issue_id"], name: "index_spina_admin_journal_articles_on_issue_id"
    t.index ["licence_id"], name: "index_spina_admin_journal_articles_on_licence_id"
  end

  create_table "spina_admin_journal_authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "orcid", default: "", null: false
  end

  create_table "spina_admin_journal_authorships", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "affiliation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.index ["affiliation_id", "article_id"], name: "index_authorships_on_affiliation_id_and_article_id", unique: true
    t.index ["affiliation_id"], name: "index_spina_admin_journal_authorships_on_affiliation_id"
    t.index ["article_id", "affiliation_id"], name: "index_authorships_on_article_id_and_affiliation_id", unique: true
    t.index ["article_id"], name: "index_spina_admin_journal_authorships_on_article_id"
  end

  create_table "spina_admin_journal_institutions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_admin_journal_issues", force: :cascade do |t|
    t.integer "number", null: false
    t.string "title", default: "", null: false
    t.date "date", null: false
    t.integer "volume_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "json_attributes"
    t.index ["volume_id"], name: "index_spina_admin_journal_issues_on_volume_id"
  end

  create_table "spina_admin_journal_journals", force: :cascade do |t|
    t.string "name", default: "Unnamed Journal", null: false
    t.integer "singleton_guard", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "json_attributes"
    t.index ["singleton_guard"], name: "index_spina_admin_journal_journals_on_singleton_guard", unique: true
  end

  create_table "spina_admin_journal_licences", force: :cascade do |t|
    t.string "name", default: "Unnamed Licence", null: false
    t.string "abbreviated_name", default: "", null: false
    t.jsonb "json_attributes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_admin_journal_parts", force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "partable_type"
    t.integer "partable_id"
    t.string "pageable_type"
    t.integer "pageable_id"
  end

  create_table "spina_admin_journal_volumes", force: :cascade do |t|
    t.integer "number", null: false
    t.string "title", default: "", null: false
    t.integer "journal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_spina_admin_journal_volumes_on_journal_id"
  end

  create_table "spina_attachment_collections", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_attachment_collections_attachments", id: :serial, force: :cascade do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", id: :serial, force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_blog_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["slug"], name: "index_spina_blog_categories_on_slug"
  end

  create_table "spina_blog_category_translations", force: :cascade do |t|
    t.string "name"
    t.string "locale", null: false
    t.bigint "spina_blog_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "spina_blog_category_translations_on_locale"
    t.index ["spina_blog_category_id", "locale"], name: "spina_blog_category_translations_on_locale_and_id", unique: true
  end

  create_table "spina_blog_post_translations", force: :cascade do |t|
    t.string "title"
    t.text "excerpt"
    t.text "content"
    t.string "seo_title"
    t.text "description"
    t.string "locale", null: false
    t.bigint "spina_blog_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "spina_blog_post_translations_on_locale"
    t.index ["spina_blog_post_id", "locale"], name: "spina_blog_post_translations_on_locale_and_id", unique: true
  end

  create_table "spina_blog_posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "excerpt"
    t.text "content"
    t.integer "image_id"
    t.boolean "draft"
    t.datetime "published_at", precision: nil
    t.string "slug"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "category_id"
    t.boolean "featured", default: false
    t.string "seo_title"
    t.text "description"
    t.index ["category_id"], name: "index_spina_blog_posts_on_category_id"
    t.index ["image_id"], name: "index_spina_blog_posts_on_image_id"
    t.index ["slug"], name: "index_spina_blog_posts_on_slug"
    t.index ["user_id"], name: "index_spina_blog_posts_on_user_id"
  end

  create_table "spina_conferences_conference_translations", force: :cascade do |t|
    t.string "name"
    t.string "locale", null: false
    t.integer "spina_conferences_conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_b1ed8f417185e6e49c50c1f2119c86824e3e3a22"
    t.index ["spina_conferences_conference_id", "locale"], name: "index_0022b227e0816c00e61de831f2d638f1b305868e", unique: true
  end

  create_table "spina_conferences_conferences", force: :cascade do |t|
    t.daterange "dates", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "json_attributes"
  end

  create_table "spina_conferences_conferences_delegates", id: false, force: :cascade do |t|
    t.bigint "spina_conferences_conference_id", null: false
    t.bigint "spina_conferences_delegate_id", null: false
  end

  create_table "spina_conferences_date_parts", force: :cascade do |t|
    t.date "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_conferences_delegates", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email_address"
    t.string "url"
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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

  create_table "spina_conferences_dietary_requirement_translations", force: :cascade do |t|
    t.string "name"
    t.string "locale", null: false
    t.integer "spina_conferences_dietary_requirement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_e52faf9b7cbf3a3d55057c84094a3a10b5de6fdd"
    t.index ["spina_conferences_dietary_requirement_id", "locale"], name: "index_70c4d45aefa2ef2619dd91b976391c1025d86e89", unique: true
  end

  create_table "spina_conferences_dietary_requirements", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_conferences_email_address_parts", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_conferences_event_translations", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "locale", null: false
    t.integer "spina_conferences_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_spina_conferences_event_translations_on_locale"
    t.index ["spina_conferences_event_id", "locale"], name: "index_a26428290c005036f14c7c9cab5f5a91289e46e0", unique: true
  end

  create_table "spina_conferences_events", force: :cascade do |t|
    t.datetime "start_datetime", precision: nil
    t.datetime "finish_datetime", precision: nil
    t.integer "conference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_spina_conferences_events_on_conference_id"
  end

  create_table "spina_conferences_institution_translations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "locale", null: false
    t.integer "spina_conferences_institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_9bff91c74e064cdc801502a3787ebe9a10fdecd1"
    t.index ["spina_conferences_institution_id", "locale"], name: "index_28cf5cb308f9303c2ac50856f314ece46e11d90e", unique: true
  end

  create_table "spina_conferences_institutions", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "logo_id"
    t.index ["logo_id"], name: "index_spina_conferences_institutions_on_logo_id"
  end

  create_table "spina_conferences_parts", force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "partable_type"
    t.integer "partable_id"
    t.string "pageable_type"
    t.integer "pageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_presentation_attachment_type_translations", force: :cascade do |t|
    t.string "name"
    t.string "locale", null: false
    t.integer "spina_conferences_presentation_attachment_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_f3417b08c78b5a87825d3f14b49fb06e76b8bed4"
    t.index ["spina_conferences_presentation_attachment_type_id", "locale"], name: "index_1b650dff92fcf8462275bfd83c507ea5c40b3ebb", unique: true
  end

  create_table "spina_conferences_presentation_attachment_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_conferences_presentation_attachments", force: :cascade do |t|
    t.integer "presentation_id", null: false
    t.integer "attachment_type_id", null: false
    t.integer "attachment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachment_id"], name: "index_conferences_presentation_attachments_on_attachment_id"
    t.index ["attachment_type_id"], name: "index_conferences_presentation_attachments_on_type_id"
    t.index ["presentation_id"], name: "index_conferences_presentation_attachments_on_presentation_id"
  end

  create_table "spina_conferences_presentation_translations", force: :cascade do |t|
    t.string "title"
    t.string "locale", null: false
    t.integer "spina_conferences_presentation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_0cda3821bc3be79968f9671e2a1d655e2307ad5b"
    t.index ["spina_conferences_presentation_id", "locale"], name: "index_a9e38adc19b163962a915fe8d3d1f2415f0c83a0", unique: true
  end

  create_table "spina_conferences_presentation_type_translations", force: :cascade do |t|
    t.string "name"
    t.string "locale", null: false
    t.integer "spina_conferences_presentation_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_22c39c0f300797c95ab75d46960dc27730d2065f"
    t.index ["spina_conferences_presentation_type_id", "locale"], name: "index_fa3b8cb99b12895308e3fc943d6db212ce4408d0", unique: true
  end

  create_table "spina_conferences_presentation_types", force: :cascade do |t|
    t.interval "duration", null: false
    t.bigint "conference_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["conference_id"], name: "index_spina_conferences_presentation_types_on_conference_id"
  end

  create_table "spina_conferences_presentations", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "start_datetime", precision: nil, null: false
    t.jsonb "json_attributes"
    t.index ["session_id"], name: "index_spina_conferences_presentations_on_session_id"
  end

  create_table "spina_conferences_room_translations", force: :cascade do |t|
    t.string "building"
    t.string "number"
    t.string "locale", null: false
    t.integer "spina_conferences_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_spina_conferences_room_translations_on_locale"
    t.index ["spina_conferences_room_id", "locale"], name: "index_a83edb40b92a36d42b882b3a9adf6d2be543dee7", unique: true
  end

  create_table "spina_conferences_rooms", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["institution_id"], name: "index_spina_conferences_rooms_on_institution_id"
  end

  create_table "spina_conferences_session_translations", force: :cascade do |t|
    t.string "name"
    t.string "locale", null: false
    t.integer "spina_conferences_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locale"], name: "index_spina_conferences_session_translations_on_locale"
    t.index ["spina_conferences_session_id", "locale"], name: "index_7843e68c4bf93df06700ea7f68c4765ef004169a", unique: true
  end

  create_table "spina_conferences_sessions", force: :cascade do |t|
    t.bigint "presentation_type_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["presentation_type_id"], name: "index_spina_conferences_sessions_on_presentation_type_id"
    t.index ["room_id"], name: "index_spina_conferences_sessions_on_room_id"
  end

  create_table "spina_conferences_time_parts", force: :cascade do |t|
    t.datetime "content", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_conferences_url_parts", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_image_collections", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["media_folder_id"], name: "index_spina_images_on_media_folder_id"
  end

  create_table "spina_layout_parts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.integer "layout_partable_id"
    t.string "layout_partable_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "account_id"
  end

  create_table "spina_line_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_line_id", null: false
    t.string "locale", null: false
    t.string "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_spina_line_translations_on_locale"
    t.index ["spina_line_id"], name: "index_spina_line_translations_on_spina_line_id"
  end

  create_table "spina_lines", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_media_folders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_navigation_items", id: :serial, force: :cascade do |t|
    t.integer "page_id", null: false
    t.integer "navigation_id", null: false
    t.integer "position", default: 0, null: false
    t.string "ancestry"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["page_id", "navigation_id"], name: "index_spina_navigation_items_on_page_id_and_navigation_id", unique: true
  end

  create_table "spina_navigations", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.boolean "auto_add_pages", default: false, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_spina_navigations_on_name", unique: true
  end

  create_table "spina_options", id: :serial, force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_page_parts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "url_title"
    t.index ["locale"], name: "index_spina_page_translations_on_locale"
    t.index ["spina_page_id"], name: "index_spina_page_translations_on_spina_page_id"
  end

  create_table "spina_pages", id: :serial, force: :cascade do |t|
    t.boolean "show_in_menu", default: true
    t.string "slug"
    t.boolean "deletable", default: true
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.jsonb "json_attributes"
    t.index ["resource_id"], name: "index_spina_pages_on_resource_id"
  end

  create_table "spina_parts_admin_journal_page_ranges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_parts_conferences_primer_theme_checkboxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "label"
    t.string "view_template"
    t.integer "parent_page_id"
    t.string "order_by"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "slug"
    t.index ["parent_page_id"], name: "index_spina_resources_on_parent_page_id"
  end

  create_table "spina_rewrite_rules", id: :serial, force: :cascade do |t|
    t.string "old_path"
    t.string "new_path"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_settings", id: :serial, force: :cascade do |t|
    t.string "plugin"
    t.jsonb "preferences", default: {}
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["plugin"], name: "index_spina_settings_on_plugin"
  end

  create_table "spina_structure_items", id: :serial, force: :cascade do |t|
    t.integer "structure_id"
    t.integer "position"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id"
  end

  create_table "spina_structure_parts", id: :serial, force: :cascade do |t|
    t.integer "structure_item_id"
    t.integer "structure_partable_id"
    t.string "structure_partable_type"
    t.string "name"
    t.string "title"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id"
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id"
  end

  create_table "spina_structures", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_text_translations", id: :serial, force: :cascade do |t|
    t.integer "spina_text_id", null: false
    t.string "locale", null: false
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_spina_text_translations_on_locale"
    t.index ["spina_text_id"], name: "index_spina_text_translations_on_spina_text_id"
  end

  create_table "spina_texts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "last_logged_in", precision: nil
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at", precision: nil
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "spina_admin_journal_affiliations", "spina_admin_journal_authors", column: "author_id"
  add_foreign_key "spina_admin_journal_affiliations", "spina_admin_journal_institutions", column: "institution_id"
  add_foreign_key "spina_admin_journal_articles", "spina_admin_journal_issues", column: "issue_id"
  add_foreign_key "spina_admin_journal_articles", "spina_admin_journal_licences", column: "licence_id"
  add_foreign_key "spina_admin_journal_authorships", "spina_admin_journal_affiliations", column: "affiliation_id"
  add_foreign_key "spina_admin_journal_authorships", "spina_admin_journal_articles", column: "article_id"
  add_foreign_key "spina_admin_journal_issues", "spina_admin_journal_volumes", column: "volume_id"
  add_foreign_key "spina_admin_journal_volumes", "spina_admin_journal_journals", column: "journal_id"
  add_foreign_key "spina_blog_category_translations", "spina_blog_categories"
  add_foreign_key "spina_blog_post_translations", "spina_blog_posts"
  add_foreign_key "spina_blog_posts", "spina_images", column: "image_id"
  add_foreign_key "spina_blog_posts", "spina_users", column: "user_id"
  add_foreign_key "spina_conferences_conference_translations", "spina_conferences_conferences"
  add_foreign_key "spina_conferences_delegates", "spina_conferences_institutions", column: "institution_id", on_delete: :cascade
  add_foreign_key "spina_conferences_dietary_requirement_translations", "spina_conferences_dietary_requirements", on_delete: :cascade
  add_foreign_key "spina_conferences_event_translations", "spina_conferences_events"
  add_foreign_key "spina_conferences_events", "spina_conferences_conferences", column: "conference_id", on_delete: :cascade
  add_foreign_key "spina_conferences_institution_translations", "spina_conferences_institutions", on_delete: :cascade
  add_foreign_key "spina_conferences_institutions", "spina_images", column: "logo_id", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_attachment_type_translations", "spina_conferences_presentation_attachment_types", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_attachments", "spina_attachments", column: "attachment_id", on_delete: :nullify
  add_foreign_key "spina_conferences_presentation_attachments", "spina_conferences_presentation_attachment_types", column: "attachment_type_id", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_attachments", "spina_conferences_presentations", column: "presentation_id", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_translations", "spina_conferences_presentations", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_type_translations", "spina_conferences_presentation_types", on_delete: :cascade
  add_foreign_key "spina_conferences_presentation_types", "spina_conferences_conferences", column: "conference_id", on_delete: :cascade
  add_foreign_key "spina_conferences_presentations", "spina_conferences_sessions", column: "session_id", on_delete: :cascade
  add_foreign_key "spina_conferences_room_translations", "spina_conferences_rooms", on_delete: :cascade
  add_foreign_key "spina_conferences_rooms", "spina_conferences_institutions", column: "institution_id", on_delete: :cascade
  add_foreign_key "spina_conferences_session_translations", "spina_conferences_sessions"
  add_foreign_key "spina_conferences_sessions", "spina_conferences_presentation_types", column: "presentation_type_id", on_delete: :cascade
  add_foreign_key "spina_conferences_sessions", "spina_conferences_rooms", column: "room_id"
end
