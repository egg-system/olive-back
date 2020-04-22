# store_id:2はエステの店舗が予約済み
Store.where(id: 3).first_or_create!(
  store_type: 0, 
  name: '女性専門の治療院オリーヴボディケア　直営テスト店', 
  address: '東京都新宿区', 
  tel: '000-000-000', 
  mail: 'tt.wing001@gmail.com', 
  url: 'https://eggsystem.co.jp/', 
  open_at: '10:00', 
  close_at: '20:00'
)
  
Store.where(id: 4).first_or_create!(
  store_type: 1, 
  name: '女性専門の治療院オリーヴボディケア　FCテスト店', 
  address: '東京都新宿区', 
  tel: '000-000-000', 
  mail: 'tt.wing002@gmail.com', 
  url: 'https://eggsystem.co.jp/', 
  open_at: '10:00', 
  close_at: '20:00'
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
  searched_by: 'オリーブ',
  nearest_station_id: 1,
  size_id: 1,
  has_registration_card: false
)
