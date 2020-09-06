# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_29_091348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_applications", force: :cascade do |t|
    t.text "adoptor_terms"
    t.boolean "read_by_pet_owner", default: false
    t.boolean "accepted", default: false
    t.bigint "user_id", null: false
    t.bigint "pet_id", null: false
    t.bigint "pet_owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id"], name: "index_adoption_applications_on_pet_id"
    t.index ["pet_owner_id"], name: "index_adoption_applications_on_pet_owner_id"
    t.index ["user_id"], name: "index_adoption_applications_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "contents", default: [], array: true
    t.string "images", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.integer "age"
    t.integer "years"
    t.integer "months"
    t.string "city"
    t.string "size"
    t.text "description"
    t.string "pet_type"
    t.string "gender"
    t.string "behavior"
    t.string "breed"
    t.string "images", default: [], array: true
    t.boolean "adopted", default: false
    t.boolean "vaccinated", default: false
    t.boolean "healthy", default: true
    t.boolean "spayed", default: false
    t.boolean "relocate", default: false
    t.boolean "potty_trained", default: false
    t.boolean "registered", default: false
    t.boolean "featured", default: false
    t.float "longitude"
    t.float "latitude"
    t.integer "viewed_times", default: 0
    t.string "adopted_via"
    t.date "adopted_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "city"
    t.string "wechat"
    t.string "phone"
    t.string "email"
    t.string "gender"
    t.string "images", default: [], array: true
    t.text "description"
    t.boolean "pet_owner", default: false
    t.boolean "pet_adopter", default: false
    t.boolean "shelter", default: false
    t.boolean "admin", default: false
    t.string "wx_open_id"
    t.string "wx_session_key"
    t.text "rescuer_terms"
    t.string "favorited_pets", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "adoption_applications", "pets"
  add_foreign_key "adoption_applications", "users"
  add_foreign_key "adoption_applications", "users", column: "pet_owner_id"
  add_foreign_key "articles", "users"
  add_foreign_key "pets", "users"
end
