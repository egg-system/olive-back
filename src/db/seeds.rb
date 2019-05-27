# 本番データ投入用のseeder
ActiveRecord::Base.transaction do
  Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')) do |file|
    load(file)
  end
end

# テストデータ用のseeder 本番でも実行させたい場合は環境変数を渡して、実行する
doSeed = ENV.fetch('PREVENT_SEED_TEST_DATA', "1") === "0"
ActiveRecord::Base.transaction do
  if Rails.env.development? || doSeed
    Dir.glob(File.join(Rails.root, 'db', 'seeds', 'test', '*.rb')) do |file|
      load(file)
    end
  end
end