class Customers::CsvController < ApplicationController
  require 'csv'

  COLUMNS = [
    "顧客ID",
    "FMID",
    "姓",
    "名",
    "セイ",
    "メイ",
    "電話番号",
    "固定電話番号",
    "メールアドレス",
    "ログインID",
    "パスワード",
    "メール受け取り",
    "初回ご来店店舗",
    "初回ご来店日",
    "直近ご来店店舗",
    "コメント",
    "郵便番号",
    "住所",
    "生年月日",
    "年齢",
    "カルテNo",
    "診察券発行有無",
    "紹介者",
    "来店経緯",
    "最寄駅",
    "Web検索",
    "お子様の数",
    "赤ちゃんの年齢",
    "職業",
    "動物占い",
    "サイズ",
    "使用状況",
    "売上総額",
    "square連携"
  ]

  def index
    @customers = Customer.all
    filename = 'customers_' + Date.current.strftime("%Y%m%d")

    data = generate_customer_data
    send_data data, filename: filename, type: 'csv'
  end

  private

  def generate_customer_data
    # 先に取得しておく
    stores = Store.all
    visit_reasons = VisitReason.all
    nearest_stations = NearestStation.all
    baby_ages = BabyAge.all
    occupations = Occupation.all
    zoomancies = Zoomancy.all
    sizes = Size.all

    CSV.generate do |csv|
      csv << COLUMNS
      @customers.each do |customer|
        first_visit_store = stores.find { |store| store.id == customer.first_visit_store_id }
        last_visit_store = stores.find { |store| store.id == customer.last_visit_store_id }
        visit_reason = visit_reasons.find { |reason| reason.id == customer.visit_reason_id }
        nearest_station = nearest_stations.find { |station| station.id == customer.nearest_station_id }
        baby_age = baby_ages.find { |baby_age| baby_age.id == customer.baby_age_id }
        occupation = occupations.find { |occupation| occupation.id == customer.occupation_id }
        zoomancy = zoomancies.find { |zoomancy| zoomancy.id == customer.zoomancy_id }
        size = sizes.find { |size| size.id == customer.size_id }

        values = [
          customer.id,
          customer.fmid,
          customer.last_name,
          customer.first_name,
          customer.last_kana,
          customer.first_kana,
          customer.tel,
          customer.fixed_line_tel,
          customer.display_email,
          customer.uid,
          customer.password,
          customer.can_receive_mail,
          first_visit_store ? first_visit_store.name : '',
          customer.first_visited_at,
          last_visit_store ? last_visit_store.name : '',
          customer.comment,
          customer.zip_code,
          customer.address,
          customer.birthday,
          customer.age,
          customer.card_number,
          customer.has_registration_card,
          customer.introducer,
          visit_reason ? visit_reason.name : '',
          nearest_station ? nearest_station.name : '',
          customer.searched_by,
          customer.children_count,
          baby_age ? baby_age.name : '',
          occupation ? occupation.name : '',
          zoomancy ? zoomancy.name : '',
          size ? size.name : '',
          customer.is_deleted,
          customer.fm_total_amount,
          customer.square_customer_exists?,
        ]
        csv << values
      end
    end
  end

end
