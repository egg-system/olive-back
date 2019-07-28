# frozen_string_literal: true

# 本番に近いテストデータ用

# スタッフ

# 1：赤川（2店舗所属、柔道整復師＆鍼灸師、正社員）
Staff.where(id: 1).first_or_create!(
  login: 'akagawa',
  password: 'password',
  first_name: '花子',
  last_name: '赤川',
  first_kana: 'ハナコ',
  last_kana: 'アカガワ',
  role_id: 3,
  employment_type: 0,
  skill_staffs: [
    SkillStaff.where(id: 1).first_or_initialize(staff_id: 1, skill_id: 1),
    SkillStaff.where(id: 2).first_or_initialize(staff_id: 1, skill_id: 2)
  ],
  store_staffs: [
    StoreStaff.where(id: 1).first_or_initialize(staff_id: 1, store_id: 1),
    StoreStaff.where(id: 2).first_or_initialize(staff_id: 1, store_id: 2)
  ]
)

# 2：田坂（2店舗所属、柔道整復師＆鍼灸師、正社員）
Staff.where(id: 2).first_or_create!(
  login: 'tasaka',
  password: 'password',
  first_name: '花子',
  last_name: '田坂',
  first_kana: 'ハナコ',
  last_kana: 'タサカ',
  role_id: 3,
  employment_type: 0,
  skill_staffs: [
    SkillStaff.where(id: 3).first_or_initialize(staff_id: 2, skill_id: 1),
    SkillStaff.where(id: 4).first_or_initialize(staff_id: 2, skill_id: 2)
  ],
  store_staffs: [
    StoreStaff.where(id: 3).first_or_initialize(staff_id: 2, store_id: 1),
    StoreStaff.where(id: 4).first_or_initialize(staff_id: 2, store_id: 2)
  ]
)

# 3：鈴木（オリーヴ所属、柔道整復師、正社員）
Staff.where(id: 3).first_or_create!(
  login: 'suzuki',
  password: 'password',
  first_name: '花子',
  last_name: '鈴木',
  first_kana: 'ハナコ',
  last_kana: 'スズキ',
  role_id: 4,
  employment_type: 0,
  skill_staffs: [SkillStaff.where(id: 5).first_or_initialize(staff_id: 3, skill_id: 1)],
  store_staffs: [StoreStaff.where(id: 5).first_or_initialize(staff_id: 3, store_id: 1)]
)

# 4：國分（オリーヴ所属、柔道整復師、バイト）
Staff.where(id: 4).first_or_create!(
  login: 'kokubun',
  password: 'password',
  first_name: '花子',
  last_name: '國分',
  first_kana: 'ハナコ',
  last_kana: 'コクブン',
  role_id: 4,
  employment_type: 0,
  skill_staffs: [SkillStaff.where(id: 6).first_or_initialize(staff_id: 4, skill_id: 1)],
  store_staffs: [StoreStaff.where(id: 6).first_or_initialize(staff_id: 4, store_id: 1)]
)

# 5：金森（オリーヴ所属、柔道整復師＆鍼灸師、バイト）
Staff.where(id: 5).first_or_create!(
  login: 'kanamori',
  password: 'password',
  first_name: '花子',
  last_name: '金森',
  first_kana: 'ハナコ',
  last_kana: 'カナモリ',
  role_id: 4,
  employment_type: 2,
  skill_staffs: [
    SkillStaff.where(id: 7).first_or_initialize(staff_id: 5, skill_id: 1),
    SkillStaff.where(id: 8).first_or_initialize(staff_id: 5, skill_id: 2)
  ],
  store_staffs: [StoreStaff.where(id: 7).first_or_initialize(staff_id: 5, store_id: 1)]
)

# 6：牧野（オリーヴ所属、柔道整復師、正社員）
Staff.where(id: 6).first_or_create!(
  login: 'makino',
  password: 'password',
  first_name: '花子',
  last_name: '牧野',
  first_kana: 'ハナコ',
  last_kana: 'マキノ',
  role_id: 4,
  employment_type: 0,
  skill_staffs: [SkillStaff.where(id: 9).first_or_initialize(staff_id: 6, skill_id: 1)],
  store_staffs: [StoreStaff.where(id: 8).first_or_initialize(staff_id: 6, store_id: 1)]
)

# 7：水谷（オリーヴ所属、柔道整復師＆鍼灸師、正社員）
Staff.where(id: 7).first_or_create!(
  login: 'mizutani',
  password: 'password',
  first_name: '花子',
  last_name: '水谷',
  first_kana: 'ハナコ',
  last_kana: 'ミズタニ',
  role_id: 4,
  employment_type: 0,
  skill_staffs: [
    SkillStaff.where(id: 10).first_or_initialize(staff_id: 7, skill_id: 1),
    SkillStaff.where(id: 11).first_or_initialize(staff_id: 7, skill_id: 2)
  ],
  store_staffs: [StoreStaff.where(id: 9).first_or_initialize(staff_id: 7, store_id: 1)]
)

# 8：鎌田（オリーヴ所属、柔道整復師、バイト）
Staff.where(id: 8).first_or_create!(
  login: 'kamata',
  password: 'password',
  first_name: '花子',
  last_name: '鎌田',
  first_kana: 'ハナコ',
  last_kana: 'カマタ',
  role_id: 4,
  employment_type: 2,
  skill_staffs: [SkillStaff.where(id: 12).first_or_initialize(staff_id: 8, skill_id: 1)],
  store_staffs: [StoreStaff.where(id: 10).first_or_initialize(staff_id: 8, store_id: 1)]
)

# 9：テストスタッフ（管理者権限、2店舗所属、柔道整復師＆鍼灸師、契約社員）
Staff.where(id: 9).first_or_create!(
  login: 'test1',
  password: 'password',
  first_name: '花子',
  last_name: '管理者',
  first_kana: 'ハナコ',
  last_kana: 'カンリシャ',
  role_id: 1,
  employment_type: 1,
  skill_staffs: [
    SkillStaff.where(id: 13).first_or_initialize(staff_id: 9, skill_id: 1),
    SkillStaff.where(id: 14).first_or_initialize(staff_id: 9, skill_id: 2)
  ],
  store_staffs: [
    StoreStaff.where(id: 11).first_or_initialize(staff_id: 9, store_id: 1),
    StoreStaff.where(id: 12).first_or_initialize(staff_id: 9, store_id: 2)
  ]
)

# 10：テストスタッフ（スタッフ権限、2店舗所属、柔道整復師＆鍼灸師、契約社員）
Staff.where(id: 10).first_or_create!(
  login: 'test2',
  password: 'password',
  first_name: '花子',
  last_name: 'スタッフ',
  first_kana: 'ハナコ',
  last_kana: 'スタッフ',
  role_id: 1,
  employment_type: 1,
  skill_staffs: [
    SkillStaff.where(id: 15).first_or_initialize(staff_id: 10, skill_id: 1),
    SkillStaff.where(id: 16).first_or_initialize(staff_id: 10, skill_id: 2)
  ],
  store_staffs: [
    StoreStaff.where(id: 13).first_or_initialize(staff_id: 10, store_id: 1),
    StoreStaff.where(id: 14).first_or_initialize(staff_id: 10, store_id: 2)
  ]
)
