ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# テストデータにはseedsを利用
# fixturesのデータはテストごとにピンポイントで必要なものをsetupで読み込む用
ActiveRecord::Base.transaction do
  Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')) do |file|
    load(file)
  end
  Dir.glob(File.join(Rails.root, 'db', 'seeds', 'test', '*.rb')) do |file|
    load(file)
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
end
