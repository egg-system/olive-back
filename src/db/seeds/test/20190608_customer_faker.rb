# 本番にはfakerを入れていないため、開発環境のみ実行
return unless Rails.env.development?

customer = 41.times do |n|
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    first_kana: Faker::Name.prefix,
    last_kana: Faker::Name.suffix,
    tel: '09010001000',
    email: Faker::Internet.email,
    password: 'test1234',
    can_receive_mail: true,
    birthday: '1985-1-1',
    zip_code: Faker::Address.zip_code,
    prefecture: Faker::Address.state,
    city: Faker::Address.full_address,
    address: Faker::Address.full_address,
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
end
