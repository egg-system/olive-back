# store_id:2はエステの店舗が予約済み
Store.where(id: 3).first_or_create!(
  store_type: 0, 
  name:'女性専門の治療院オリーヴボディケア　直営テスト店', 
  address:'東京都新宿区', 
  tel:'000-000-000', 
  mail:'tt.wing001@gmail.com', 
  url:'https://eggsystem.co.jp/', 
  open_at:'10:00', 
  close_at:'20:00'
)
  
Store.where(id: 4).first_or_create!(
  store_type: 1, 
  name:'女性専門の治療院オリーヴボディケア　FCテスト店', 
  address:'東京都新宿区', 
  tel:'000-000-000', 
  mail:'tt.wing002@gmail.com', 
  url:'https://eggsystem.co.jp/', 
  open_at:'10:00', 
  close_at:'20:00'
) 

customer = Customer.where(id: 1).first_or_create!(
  first_name: '顧客', 
  last_name: '高橋', 
  first_kana: 'コキャク',
  last_kana: 'タカハシ', 
  tel: '09010001000', 
  email: 'test@test.com',
  password: 'test1234',
  can_receive_mail: true, 
  birthday: '1985-1-1', 
  zip_code: '160-0022', 
  prefecture: '東京都', 
  city: '新宿区新宿１−１−１　なんとかビル１階', 
  address: '東京都	新宿区新宿１−１−１　なんとかビル１階',
  comment: 'コメントです', 
  first_visit_store_id: 1, 
  last_visit_store_id: 2, 
  first_visited_at: '2019-01-01', 
  last_visited_at: '2019-02-01',
  card_number: 999,
  children_count: 1,
  occupation_id: 1,
  zoomancy_id: 1,
  baby_age_id: 1,
  visit_reason_id: 1,
  introducer: '山田',
  searchd_by: 'オリーブ',
  nearest_station_id: 1,
  size_id: 1,
  has_registration_card: false
)

# テストデータ用
Staff.where(id: 2).first_or_create!(
  login: 'test1', 
  password: 'password',
  first_name: '恵子',
  last_name: '本部',
  first_kana: 'ケイコ',
  last_kana: 'ホンブ',
  role_id: 2,
  employment_type: 0,
  skill_staffs: [ SkillStaff.where(id: 3).first_or_initialize(staff_id: 2, skill_id: 1) ],
  store_staffs: [ StoreStaff.where(id: 2).first_or_initialize(staff_id: 2, store_id: 1) ],
)

Staff.where(id: 3).first_or_create!(
  login: 'test2',
  password: 'password',
  first_name: '愛子',
  last_name: '店長',
  first_kana: 'アイコ',
  last_kana: 'テンチョウ',
  role_id: 3,
  employment_type:1,
  skill_staffs: [ SkillStaff.where(id: 4).first_or_initialize(staff_id: 3, skill_id: 1) ],
  store_staffs: [ StoreStaff.where(id: 3).first_or_initialize(staff_id: 3, store_id: 1) ],
)

Staff.where(id: 4).first_or_create!(
  login: 'test3',
  password: 'password',
  first_name: '綾子',
  last_name: '佐藤',
  first_kana: 'アヤコ',
  last_kana: 'サトウ',
  role_id: 4,
  employment_type: 1,
  skill_staffs: [ SkillStaff.where(id: 5).first_or_initialize(staff_id: 4, skill_id: 2) ],
  store_staffs: [ 
    StoreStaff.where(id: 4).first_or_initialize(staff_id: 4, store_id: 1),
    StoreStaff.where(id: 5).first_or_initialize(staff_id: 4, store_id: 2),
  ],
)

Staff.where(id: 5).first_or_create!(
  login: 'test4',
  password: 'password',
  first_name: '恵理子',
  last_name: '田中',
  first_kana: 'エリコ',
  last_kana: 'タナカ',
  role_id: 4,
  employment_type: 2,
  skill_staffs: [ SkillStaff.where(id: 6).first_or_initialize(staff_id: 5, skill_id: 2) ],
  store_staffs: [ StoreStaff.where(id: 6).first_or_initialize(staff_id: 5, store_id: 2) ],
)

Staff.where(id: 6).first_or_create!(
  login: 'test5',
  password: 'password', 
  first_name:'恵理子',
  last_name:'鈴木',
  first_kana:'エリコ',
  last_kana:'スズキ', 
  role_id: 4,
  employment_type: 2,
  skill_staffs: [
    SkillStaff.where(id: 7).first_or_initialize(staff_id: 6, skill_id: 1),
    SkillStaff.where(id: 8).first_or_initialize(staff_id: 6, skill_id: 2)
  ],
  store_staffs: [
    StoreStaff.where(id: 7).first_or_initialize(staff_id: 6, store_id: 3),
  ],
)
