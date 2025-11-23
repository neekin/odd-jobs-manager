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

ActiveRecord::Schema[8.1].define(version: 2025_11_23_113230) do
  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "gig_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "remark"
    t.datetime "updated_at", null: false
  end

  create_table "gig_user_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "gig_user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["gig_user_id", "tag_id"], name: "index_gig_user_tags_on_gig_user_id_and_tag_id", unique: true
    t.index ["gig_user_id"], name: "index_gig_user_tags_on_gig_user_id"
    t.index ["tag_id"], name: "index_gig_user_tags_on_tag_id"
  end

  create_table "gig_users", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "city", default: ""
    t.string "country", default: ""
    t.datetime "created_at", null: false
    t.bigint "createtime"
    t.string "czr"
    t.bigint "deletetime"
    t.string "fz_id"
    t.integer "gig_group_id"
    t.string "group_remark", default: ""
    t.string "headimgurl", limit: 256, default: ""
    t.string "isOnline", limit: 1, default: "1"
    t.string "isParent", limit: 1, default: "0"
    t.string "language", default: ""
    t.bigint "lastpay_time"
    t.string "late_czr"
    t.string "late_status", limit: 1, default: "3"
    t.float "money", default: 0.0, null: false
    t.string "nickname", limit: 64, default: ""
    t.string "openid", limit: 80, default: ""
    t.integer "parent_id", default: 0
    t.string "parent_serialno"
    t.string "pay_image"
    t.string "pay_type", limit: 10, default: "wxpay"
    t.string "phone"
    t.string "province", default: ""
    t.string "remark", default: ""
    t.string "serialno", default: ""
    t.string "sex", limit: 1, default: "0"
    t.string "sh_id"
    t.string "state", limit: 1, default: "1"
    t.string "status", limit: 1, default: "1"
    t.string "subscribe", limit: 1, default: "0"
    t.bigint "subscribe_time"
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "truename", default: ""
    t.string "unionid", limit: 80, default: ""
    t.datetime "updated_at", null: false
    t.bigint "updatetime"
    t.integer "user_id", default: 0, null: false
    t.string "user_type", limit: 10, default: "wechat"
    t.string "wxapp_openid", limit: 32, default: ""
    t.integer "yz_id"
    t.string "zpr"
    t.index ["gig_group_id"], name: "index_gig_users_on_gig_group_id"
    t.index ["openid"], name: "index_gig_users_on_openid"
    t.index ["parent_id"], name: "index_gig_users_on_parent_id"
    t.index ["serialno"], name: "index_gig_users_on_serialno"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name"
  end

  add_foreign_key "gig_user_tags", "gig_users"
  add_foreign_key "gig_user_tags", "tags"
  add_foreign_key "gig_users", "gig_groups"
end
