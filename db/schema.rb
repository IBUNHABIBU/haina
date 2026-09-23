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

ActiveRecord::Schema[8.0].define(version: 2026_09_23_000000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "customer"
    t.string "phone"
    t.string "TV_brand"
    t.integer "TV_size"
    t.string "model_no"
    t.datetime "date_in"
    t.datetime "date_out"
    t.decimal "starting_price"
    t.decimal "final_price"
    t.integer "status"
    t.integer "spare_used"
    t.decimal "cost_each"
    t.decimal "total_cost"
    t.decimal "profit"
    t.text "remarks"
    t.decimal "labour_cost"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.bigint "tv_brand_id"
    t.bigint "tv_size_id"
    t.bigint "tatizo_id"
    t.decimal "price", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "labour_charge", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "gross_profit", precision: 15, scale: 2, default: "0.0", null: false
    t.integer "returned_count", default: 0, null: false
    t.index ["customer_id"], name: "index_activities_on_customer_id"
    t.index ["date_in"], name: "index_activities_on_date_in"
    t.index ["status"], name: "index_activities_on_status"
    t.index ["tatizo_id"], name: "index_activities_on_tatizo_id"
    t.index ["tv_brand_id"], name: "index_activities_on_tv_brand_id"
    t.index ["tv_size_id"], name: "index_activities_on_tv_size_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "activity_spares", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "spare_id", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "unit_cost", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "total_cost", precision: 15, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id", "spare_id"], name: "index_activity_spares_on_activity_id_and_spare_id", unique: true
    t.index ["activity_id"], name: "index_activity_spares_on_activity_id"
    t.index ["spare_id"], name: "index_activity_spares_on_spare_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "mahali"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "category", null: false
    t.string "description", null: false
    t.decimal "amount", precision: 15, scale: 2, default: "0.0", null: false
    t.date "spent_on", null: false
    t.string "reference"
    t.text "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_expenses_on_category"
    t.index ["spent_on"], name: "index_expenses_on_spent_on"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "repair_returns", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.integer "return_number", null: false
    t.datetime "returned_at", null: false
    t.string "location", null: false
    t.string "reason", null: false
    t.string "condition"
    t.string "status", default: "received", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id", "return_number"], name: "index_repair_returns_on_activity_id_and_return_number", unique: true
    t.index ["activity_id"], name: "index_repair_returns_on_activity_id"
  end

  create_table "spare_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_spare_categories_on_code", unique: true
  end

  create_table "spare_purchases", force: :cascade do |t|
    t.bigint "spare_id", null: false
    t.integer "quantity", null: false
    t.decimal "unit_cost", precision: 15, scale: 2, null: false
    t.decimal "total_cost", precision: 15, scale: 2, null: false
    t.string "supplier"
    t.date "purchased_on", null: false
    t.string "reference"
    t.text "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchased_on"], name: "index_spare_purchases_on_purchased_on"
    t.index ["spare_id"], name: "index_spare_purchases_on_spare_id"
    t.index ["user_id"], name: "index_spare_purchases_on_user_id"
  end

  create_table "spares", force: :cascade do |t|
    t.bigint "spare_category_id", null: false
    t.string "name", null: false
    t.string "part_number"
    t.string "brand"
    t.decimal "unit_cost", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "selling_price", precision: 15, scale: 2, default: "0.0", null: false
    t.integer "quantity", default: 0, null: false
    t.integer "reorder_level", default: 0, null: false
    t.string "location"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_number"], name: "index_spares_on_part_number"
    t.index ["spare_category_id"], name: "index_spares_on_spare_category_id"
  end

  create_table "tatizos", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tv_brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tv_sizes", force: :cascade do |t|
    t.decimal "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "customers"
  add_foreign_key "activities", "tatizos"
  add_foreign_key "activities", "tv_brands"
  add_foreign_key "activities", "tv_sizes"
  add_foreign_key "activities", "users"
  add_foreign_key "activity_spares", "activities"
  add_foreign_key "activity_spares", "spares"
  add_foreign_key "customers", "users"
  add_foreign_key "expenses", "users"
  add_foreign_key "repair_returns", "activities"
  add_foreign_key "spare_purchases", "spares"
  add_foreign_key "spare_purchases", "users"
  add_foreign_key "spares", "spare_categories"
end
