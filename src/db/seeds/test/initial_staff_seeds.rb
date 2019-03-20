require 'faker'

# csvインポートのテストなどのため、名前を固定にしておく
staff = Staff.find_or_initialize_by(id: 1)
staff.update_attributes!(
  role_id: 1,
  store_id: 1,
  first_name: 'オリーブ', 
  last_name: '管理者',
  login: 'test',
  password: 'password'
)
staff.save!