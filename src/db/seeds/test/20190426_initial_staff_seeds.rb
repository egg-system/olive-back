#require 'faker'

# csvインポートのテストなどのため、名前を固定にしておく
staff = Staff.find_or_initialize_by(id: 1)
staff.update_attributes!(
  role_id: 1,
  store_id: 1,
  first_name: '管理者', 
  last_name: 'オリーブ',
  first_kana: 'カンリシャ', 
  last_kana: 'オリーブ',
  login: 'test',
  password: 'password'
)
staff.save!