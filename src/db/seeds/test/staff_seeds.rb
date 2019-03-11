require 'faker'

unless Store.exists?
  3.times do
    Store.create(
      store_type: Faker::Number.between(0, 1),
      name: Faker::Company.name
    )
  end
end

unless Staff.exists?
  5.times do
    Staff.create(
      store_id: Store.order("RAND()").first().id,
      first_name: Faker::Name.first_name, 
      last_name: Faker::Name.last_name
    )
  end
end

unless User.exists?
  User.create(
    role_id: Role.order("RAND()").first().id,
    staff_id: Staff.order("RAND()").first().id,
    email: 'email@olive.test',
    password: 'password'
  )
end