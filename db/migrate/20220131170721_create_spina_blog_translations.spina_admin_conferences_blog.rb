# frozen_string_literal: true

# This migration comes from spina_admin_conferences_blog (originally 7)
class CreateSpinaBlogTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_blog_post_translations do |t|
      t.string :title
      t.text :excerpt
      t.text :content
      t.string :seo_title
      t.text :description

      t.string :locale, null: false
      t.references :spina_blog_post, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spina_blog_post_translations, :locale, name: :spina_blog_post_translations_on_locale
    add_index :spina_blog_post_translations, [:spina_blog_post_id, :locale], unique: true, name: :spina_blog_post_translations_on_locale_and_id

    create_table :spina_blog_category_translations do |t|
      t.string :name

      t.string :locale, null: false
      t.references :spina_blog_category, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spina_blog_category_translations, :locale, name: :spina_blog_category_translations_on_locale
    add_index :spina_blog_category_translations, [:spina_blog_category_id, :locale], unique: true, name: :spina_blog_category_translations_on_locale_and_id
  end
end
