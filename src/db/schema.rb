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

ActiveRecord::Schema.define(version: 2019_02_13_130118) do

  create_table "coupons", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "coupon_id"
    t.string "name"
    t.string "coupon_fee"
    t.integer "tax_id"
    t.integer "coupon_remaining"
    t.date "coupon_start_date"
    t.date "coupon_start_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "costomer_id"
    t.string "customer_first_name"
    t.string "customer_last_name"
    t.string "customer_first_name_kana"
    t.string "customer_last_name_kana"
    t.string "tel"
    t.string "mail1"
    t.string "mail2"
    t.boolean "mail_receive_flg"
    t.date "birthday"
    t.string "zip_code"
    t.string "prefecture"
    t.text "city"
    t.text "address"
    t.boolean "membership_flg"
    t.boolean "mail_flg"
    t.text "comment1"
    t.text "comment2"
    t.integer "fitsrt_visit_store_id"
    t.integer "last_visit_store_id"
    t.date "last_visit_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "department_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "department_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "menu_category_id"
    t.string "name"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "store_id"
    t.string "name"
    t.text "menu_description"
    t.integer "menu_fee"
    t.integer "tax_id"
    t.time "service_time"
    t.date "service_start_date"
    t.date "service_end_date"
    t.integer "menu_category_id"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pregnant_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "pregnant_status_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "reservation_id"
    t.integer "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "role_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "shift_id"
    t.date "shift_date"
    t.integer "store_id"
    t.integer "staff_id"
    t.time "shift_begin"
    t.time "shift_end"
    t.boolean "time_1011"
    t.boolean "time_1112"
    t.boolean "time_1213"
    t.boolean "time_1314"
    t.boolean "time_1415"
    t.boolean "time_1516"
    t.boolean "time_1617"
    t.boolean "time_1718"
    t.boolean "time_1819"
    t.boolean "time_1920"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "skill_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "staff_id"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.integer "staff_skill_id"
    t.integer "belong_store_id"
    t.integer "role_id"
    t.string "employee_type"
    t.boolean "absence_flg"
    t.boolean "deleted_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "staff_skill_id"
    t.integer "staff_id"
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_types", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "store_type_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "store_id"
    t.integer "store_type_id"
    t.string "name"
    t.text "address"
    t.string "store_tel"
    t.string "store_mail"
    t.text "store_url"
    t.date "business_hours_weekday"
    t.date "business_hours_holiday"
    t.date "last_reception_time_weekday"
    t.date "last_reception_time_holiday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "tax_id"
    t.float "tax_rate"
    t.boolean "tax_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "with_child_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "with_child_status_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
