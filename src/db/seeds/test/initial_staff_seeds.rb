require 'faker'

unless Store.exists?
  3.times do
    Store.create!(
      store_type: Faker::Number.between(0, 1),
      name: Faker::Company.name
    )
  end
end

unless Staff.exists?
  5.times do |index|
    Staff.create!(
      store_id: Store.order("RAND()").first().id,
      role_id: Role.order("RAND()").first().id,
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name,
      login: 'test#{index}',
      password: 'password'
    )
  end
end

# csvインポートのテストなどのため、名前を固定にしておく
staff = Staff.find_or_initialize_by(id: 1)
staff.update_attributes(
  role_id: 1,
  store_id: 1,
  first_name: 'オリーブ', 
  last_name: '管理者',
  login: 'test',
  password: 'password'
)
staff.save!