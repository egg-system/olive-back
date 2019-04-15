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

ActiveRecord::Schema.define(version: 2019_04_14_154726) do

  create_table "baby_ages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupon_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "coupon_id"
    t.date "used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_coupon_histories_on_coupon_id"
    t.index ["customer_id"], name: "index_coupon_histories_on_customer_id"
  end

  create_table "coupons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "fee", comment: "税別料金"
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
    t.string "pc_mail", comment: "pcメール。fileMakerから移行"
    t.string "phone_mail", comment: "携帯メール。fileMakerから移行"
    t.boolean "can_receive_mail"
    t.date "birthday"
    t.string "zip_code"
    t.string "prefecture"
    t.text "city"
    t.text "address"
    t.boolean "has_membership"
    t.text "comment"
    t.bigint "first_visit_store_id"
    t.bigint "last_visit_store_id"
    t.date "first_visited_at"
    t.date "last_visited_at"
    t.string "card_number", comment: "カルテの番号。紙媒体で管理しているため、外部キーなし"
    t.string "introducer", comment: "紹介していただいた方の名前など"
    t.string "searchd_by", comment: "web検索単語など"
    t.boolean "has_registration_card", comment: "診察券を発行したかどうか"
    t.integer "children_count", comment: "お子様の数。その他やdefault値にあたるものはnullにする"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "occupation_id", comment: "職業"
    t.bigint "zoomancy_id", comment: "動物占いの結果"
    t.bigint "baby_age_id", comment: "赤ちゃんの年齢"
    t.bigint "size_id", comment: "サイズ"
    t.bigint "visit_reason_id", comment: "来店経緯"
    t.bigint "nearest_station_id", comment: "最寄り駅"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["baby_age_id"], name: "index_customers_on_baby_age_id"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["first_visit_store_id"], name: "index_customers_on_first_visit_store_id"
    t.index ["last_visit_store_id"], name: "index_customers_on_last_visit_store_id"
    t.index ["nearest_station_id"], name: "index_customers_on_nearest_station_id"
    t.index ["occupation_id"], name: "index_customers_on_occupation_id"
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["size_id"], name: "index_customers_on_size_id"
    t.index ["visit_reason_id"], name: "index_customers_on_visit_reason_id"
    t.index ["zoomancy_id"], name: "index_customers_on_zoomancy_id"
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
    t.string "name"
    t.text "description"
    t.integer "fee"
    t.integer "service_minutes", comment: "施術時間(分)"
    t.date "start_at"
    t.date "end_at"
    t.bigint "menu_category_id"
    t.bigint "skill_id", default: 1, comment: "必須スキルを紐づける"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_category_id"], name: "index_menus_on_menu_category_id"
    t.index ["skill_id"], name: "index_menus_on_skill_id"
  end

  create_table "nearest_stations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "occupations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "skill_id"
    t.bigint "department_id"
    t.text "description"
    t.integer "fee"
    t.date "start_at"
    t.date "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_options_on_department_id"
    t.index ["skill_id"], name: "index_options_on_skill_id"
  end

  create_table "pregnant_states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.integer "children_count", default: 0, comment: "随伴するお子様の数"
    t.text "reservation_comment"
    t.bigint "customer_id"
    t.bigint "shift_id", comment: "storeやstaff、日時の情報はshiftで保持する"
    t.bigint "coupon_id"
    t.bigint "pregnant_state_id"
    t.date "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_reservations_on_coupon_id"
    t.index ["customer_id"], name: "index_reservations_on_customer_id"
    t.index ["pregnant_state_id"], name: "index_reservations_on_pregnant_state_id"
    t.index ["shift_id"], name: "index_reservations_on_shift_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "シフト。スタッフと既存の予約の組み合わせで、予約枠になる", force: :cascade do |t|
    t.date "date", comment: "シフトの日時"
    t.time "start_at", comment: "シフトの開始時間"
    t.time "end_at", comment: "シフトの終了時間。30分単位になる"
    t.bigint "store_id"
    t.bigint "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staff_id"], name: "index_shifts_on_staff_id"
    t.index ["store_id"], name: "index_shifts_on_store_id"
  end

  create_table "sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_staffs_on_skill_id"
    t.index ["staff_id"], name: "index_skill_staffs_on_staff_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "first_kana"
    t.string "last_kana"
    t.bigint "store_id"
    t.bigint "role_id"
    t.integer "employment_type", comment: "model内でenumにする。0:正社員, 1:契約社員, 2:パート・アルバイト"
    t.datetime "deleted_at"
    t.boolean "is_absenced"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.index ["login", "store_id"], name: "index_staffs_on_login_and_store_id", unique: true
    t.index ["role_id"], name: "index_staffs_on_role_id"
    t.index ["store_id"], name: "index_staffs_on_store_id"
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
    t.integer "open_at"
    t.integer "close_at"
    t.integer "break_from", comment: "休憩の開始時間"
    t.integer "break_to", comment: "休憩の終了時間"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "rate"
    t.boolean "is_default", default: false, null: false, comment: "このフラグが立っている税率がデフォルトになる"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visit_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zoomancies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "coupon_histories", "coupons"
  add_foreign_key "coupon_histories", "customers"
  add_foreign_key "customers", "baby_ages"
  add_foreign_key "customers", "nearest_stations"
  add_foreign_key "customers", "occupations"
  add_foreign_key "customers", "sizes"
  add_foreign_key "customers", "stores", column: "first_visit_store_id"
  add_foreign_key "customers", "stores", column: "last_visit_store_id"
  add_foreign_key "customers", "visit_reasons"
  add_foreign_key "customers", "zoomancies"
  add_foreign_key "menu_categories", "departments"
  add_foreign_key "menus", "menu_categories"
  add_foreign_key "menus", "skills"
  add_foreign_key "options", "departments"
  add_foreign_key "options", "skills"
  add_foreign_key "reservations", "coupons"
  add_foreign_key "reservations", "customers"
  add_foreign_key "reservations", "pregnant_states"
  add_foreign_key "shifts", "staffs"
  add_foreign_key "shifts", "stores"
  add_foreign_key "skill_staffs", "skills"
  add_foreign_key "skill_staffs", "staffs"
  add_foreign_key "staffs", "roles"
  add_foreign_key "staffs", "stores"
  add_foreign_key "store_menus", "menus"
  add_foreign_key "store_menus", "stores"
end
