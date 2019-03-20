# 本番データ投入用のseeder
ActiveRecord::Base.transaction do
  Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')) do |file|
    load(file)
  end
end

# テストデータ用のseeder
ActiveRecord::Base.transaction do
  unless Rails.env.production?
    Dir.glob(File.join(Rails.root, 'db', 'seeds', 'test', '*.rb')) do |file|
      load(file)
    end
  end
end