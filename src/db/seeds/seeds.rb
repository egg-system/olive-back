# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Rails.env.production? || User.exists?
  # User.create(
  #   email: 'admin@olive.example',
  #   password: 'password'
  # )

  Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')) do |file|
    load(file)
  end
end