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

ActiveRecord::Schema.define(version: 2019_03_11_115658) do

  create_table "coupons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "fee"
    t.integer "count", comment: "利用回数"
    t.date "start_at"
    t.date "end_at"
    t.date "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "first_kana"
    t.string "last_kana"
    t.string "tel"
    t.string "mail", comment: "メールアドレス"
    t.boolean "can_receive_mail"
    t.date "birthday"
    t.string "zip_code"
    t.string "prefecture"
    t.text "city"
    t.text "address"
    t.boolean "has_membership"
    t.text "comment"
    t.bigint "fitsrt_visit_store_id"
    t.bigint "last_visit_store_id"
    t.date "last_visited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fitsrt_visit_store_id"], name: "index_customers_on_fitsrt_visit_store_id"
    t.index ["last_visit_store_id"], name: "index_customers_on_last_visit_store_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_menu_categories_on_department_id"
  end

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "store_id"
    t.string "name"
    t.text "description"
    t.integer "fee"
    t.integer "service_minutes", comment: "施術時間(分)"
    t.date "service_start_date"
    t.date "service_end_date"
    t.bigint "menu_category_id"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_category_id"], name: "index_menus_on_menu_category_id"
  end

  create_table "pregnant_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pregnant_status_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "reservation_id"
    t.integer "customer_id"
    t.integer "staff_id"
    t.integer "coupon_id"
    t.boolean "first_visit_flg"
    t.integer "pregnant_status_id"
    t.integer "with_child_status_id"
    t.boolean "double_flg"
    t.date "reservation_date"
    t.time "start_time"
    t.time "end_time"
    t.text "reservation_comment"
    t.boolean "cancel_flg"
    t.integer "total_fee"
    t.time "total_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "shift_date"
    t.bigint "staff_id"
    t.time "start_at"
    t.time "end_at"
    t.boolean "on_shift_10_to_11", comment: "10時~11時に施術可能か"
    t.boolean "on_shift_11_to_12", comment: "11時~12時に施術可能か"
    t.boolean "on_shift_12_to_13", comment: "12時~13時に施術可能か"
    t.boolean "on_shift_13_to_14", comment: "13時~14時に施術可能か"
    t.boolean "on_shift_14_to_15", comment: "14時~15時に施術可能か"
    t.boolean "on_shift_15_to_16", comment: "15時~16時に施術可能か"
    t.boolean "on_shift_16_to_17", comment: "16時~17時に施術可能か"
    t.boolean "on_shift_17_to_18", comment: "17時~18時に施術可能か"
    t.boolean "on_shift_18_to_19", comment: "18時~19時に施術可能か"
    t.boolean "on_shift_19_to_20", comment: "19時~20時に施術可能か"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staff_id"], name: "index_shifts_on_staff_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_skills_menus_on_menu_id"
    t.index ["skill_id"], name: "index_skills_menus_on_skill_id"
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "first_kana"
    t.string "last_kana"
    t.bigint "store_id", null: false
    t.string "employment_type"
    t.datetime "deleted_at"
    t.boolean "is_absenced"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_staffs_on_store_id"
  end

  create_table "staffs_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_staffs_skills_on_skill_id"
    t.index ["staff_id"], name: "index_staffs_skills_on_staff_id"
  end

  create_table "store_menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "store_id"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_store_menus_on_menu_id"
    t.index ["store_id"], name: "index_store_menus_on_store_id"
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "store_type", default: 0, comment: "モデル内でenum型に定義 0:直営店 1:FC店"
    t.string "name"
    t.text "address"
    t.string "tel"
    t.string "mail"
    t.text "url"
    t.text "infomation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "rate"
    t.boolean "is_default", default: false, null: false, comment: "このフラグが立っている税率がデフォルトになる"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "staff_id"
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["staff_id"], name: "index_users_on_staff_id"
  end

  create_table "with_child_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "with_child_status_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customers", "stores", column: "fitsrt_visit_store_id"
  add_foreign_key "customers", "stores", column: "last_visit_store_id"
  add_foreign_key "menu_categories", "departments"
  add_foreign_key "menus", "menu_categories"
  add_foreign_key "shifts", "staffs"
  add_foreign_key "skills_menus", "menus"
  add_foreign_key "skills_menus", "skills"
  add_foreign_key "staffs", "stores"
  add_foreign_key "staffs_skills", "skills"
  add_foreign_key "staffs_skills", "staffs"
  add_foreign_key "store_menus", "menus"
  add_foreign_key "store_menus", "stores"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "staffs"
end
