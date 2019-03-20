Store.where(id: 2).first_or_create(
  store_type: 0, 
  name:'女性専門の治療院オリーヴボディケア　直営テスト店', 
  address:'東京都新宿区', 
  tel:'000-000-000', 
  mail:'tt.wing001@gmail.com', 
  url:'https://eggsystem.co.jp/', 
  open_at:'10:00', 
  close_to:'20:00'
)

Store.where(id: 3).first_or_create(
  store_type: 1, 
  name:'女性専門の治療院オリーヴボディケア　FCテスト店', 
  address:'東京都新宿区', 
  tel:'000-000-000', 
  mail:'tt.wing002@gmail.com', 
  url:'https://eggsystem.co.jp/', 
  open_at:'10:00', 
  close_to:'20:00'
)

