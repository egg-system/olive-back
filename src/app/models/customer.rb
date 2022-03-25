class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  audited except: :tokens

  include DeviseTokenAuth::Concerns::User
  include PaginationModule
  include SquareCustomerModule

  VALID_PASSWORD_REGEX = /\A(?=.*?[A-Za-z])(?=.*?\d)[A-Za-z\d]+\z/i.freeze

  JP_CSV_COLUMN_NAMES = %w[顧客ID 姓 名 セイ メイ 電話番号 固定電話番号 性別 メール受け取り サンキューレター送付済み DM配信受け取り可否 生年月日 郵便番号 都道府県 市区町村 住所 コメント 初回ご来店店舗 直近ご来店店舗 初回ご来店日 直近ご来店日 カルテNo 紹介者 Web検索 診察券発行有無 お子様の数 作成日 更新日 職業 動物占い 赤ちゃんの年齢 サイズ 来店経緯 最寄駅 メールアドレス 暗号化パスワード パスワードリセット用トークン パスワードリセット送信時刻 ログイン記憶時刻 プロパイダー uid トークン パスワード変更可否 FMID 削除済み 売上総額 顧客統合メモ].freeze

  # 顧客統合対象外のカラム
  INTEGRATE_EXCEPT_ATTRIBUTE_NAMES = %w[id email encrypted_password reset_password_token reset_password_sent_at remember_created_at provider uid tokens allow_password_change is_deleted created_at updated_at].freeze

  belongs_to(
    :first_visit_store,
    optional: true,
    class_name: 'Store',
    foreign_key: 'first_visit_store_id'
  )

  belongs_to(
    :last_visit_store,
    optional: true,
    class_name: 'Store',
    foreign_key: 'last_visit_store_id'
  )

  belongs_to :job_type, optional: true
  belongs_to :zoomancy, optional: true
  belongs_to :baby_age, optional: true
  belongs_to :size, optional: true
  belongs_to :visit_reason, optional: true
  belongs_to :nearest_station, optional: true
  belongs_to :medical_record, optional: true

  has_many :reservations
  has_many :observations

  has_many :visit_stores
  has_many :stores, through: :visit_stores

  before_validation :sync_provider
  after_save :save_visit_stores

  validates :tel, numericality: { allow_blank: true }, length: { in: 9..15 }
  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: VALID_PASSWORD_REGEX }, if: :should_validate_password?
  validates :email, uniqueness: { case_sensitive: true }, unless: :common_email?
  validates :visit_store_ids, allow_nil: true, visit_store: true

  # TODO: デフォルトで、joinが走るようにする
  scope :join_size, -> {
    left_joins(:size).select("sizes.name as size_name")
  }

  scope :join_tables, -> {
    select('customers.*').join_size
  }

  scope :like_name, ->(name) {
    where("concat(last_name, first_name) like ?", "%#{name}%") if name.present?
  }

  scope :like_kana_name, ->(kana_name) {
    where("concat(last_kana, first_kana) collate utf8_unicode_ci like ?", "%#{kana_name}%") if kana_name.present?
  }

  scope :like_tel, ->(tel) {
    where('tel LIKE ?', "%#{tel}%") if tel.present?
  }

  scope :like_email, ->(email) {
    where('email LIKE ?', "%#{email}%") if email.present?
  }

  scope :where_deleted, ->(is_deleted) {
    where(is_deleted: is_deleted)
  }

  scope :group_duplicated, ->(columns) {
    group(columns).having('count(*) >= 2')
  }

  scope :enabled, -> { where(enabled: true) }

  attr_accessor :age, :display_email, :visit_store_ids

  def self.merge(merge_from_id, merge_to_id)
    merge_from_customer = find(merge_from_id)
    merge_from_customer.reservations.update(customer_id: merge_to_id)

    merge_to_customer = find(merge_to_id)

    if !merge_to_customer.member? && merge_from_customer.member?
      merge_to_customer.uid = merge_from_customer.uid
      merge_to_customer.encrypted_password = merge_from_customer.encrypted_password
      merge_to_customer.provider = 'email'
    end

    merge_from_customer.update!(is_deleted: true)
    merge_to_customer.save!

    return merge_from_customer
  end

  def age
    return nil if self.birthday.nil?

    return (Date.today.strftime('%Y%m%d').to_i - self.birthday.strftime('%Y%m%d').to_i) / 10000
  end

  def full_name
    return "#{self.last_name} #{self.first_name}"
  end

  def full_kana
    return "#{self.last_kana} #{self.first_kana}"
  end

  def display_email
    return self.email if self.new_record?

    return self.email.nil? ? self.common_email : self.email
  end

  def display_email=(email)
    self.email = email unless email === self.common_email
    self.email = nil if email === self.common_email
  end

  def common_email?
    return self.email.nil? if self.new_record?

    return self.display_email === self.common_email
  end

  def member?
    return self.provider != 'none'
  end

  def save_visit_stores
    return unless visit_store_ids

    self.visit_stores.delete_all
    (visit_store_ids - ['', nil]).each { |id| self.visit_stores.build(store_id: id).save! }
  end

  def to_csv_values
    sorted = [self.id, self.last_name, self.first_name, self.last_kana, self.first_kana]
    sorted + self.attributes.except('id', 'first_name', 'last_name', 'first_kana', 'last_kana').values
  end

  def integrate!(integrate_customer)
    transaction do
      self.write_integrate_values(integrate_customer)

      self.save!(validate: false)

      # 予約情報と経過記録情報の紐付けを変更する
      integrate_customer.reservations.each do |reservation|
        reservation.update!(customer_id: id)
      end
      integrate_customer.observations.each do |observation|
        observation.update!(customer_id: id)
      end

      integrate_customer.enabled = false
      integrate_customer.save!(validate: false)
    end
  end

  protected

  # 会員かつ、メールアドレスかパスワードが変更された場合、パスワードをチェックする
  def should_validate_password?
    # nilからの変更は、changed? === trueとして認識されないため、下記の様に確認
    email_or_password_changed = self.email != self.email_was || self.encrypted_password != self.encrypted_password_was

    return (self.member? && email_or_password_changed) || (!self.common_email? && self.new_record?)
  end

  def sync_provider
    self.provider = self.common_email? ? 'none' : 'email'
    self.uid = self.common_email? ? SecureRandom.uuid : self.email

    # パスワードの再設定を必要にするため
    self.encrypted_password = nil if self.common_email?
  end

  def common_email
    return Settings.customer.common_email
  end

  def write_integrate_values(integrate_customer)
    memo = <<~STR
      重複した顧客情報を #{Date.today.strftime('%Y/%m/%d')} に統合しました。下記は最新の顧客情報に含まれません。
      顧客ID：#{integrate_customer.id}
      名前：#{integrate_customer.full_name}
    STR

    integrate_attribute_names.each do |attribute_name|
      value = read_attribute(attribute_name)
      integrate_value = integrate_customer.read_attribute(attribute_name)

      if value.blank? && value != false
        write_attribute(attribute_name, integrate_value)

      elsif (integrate_value.present? || integrate_value == false) && value != integrate_value
        # 値が競合した場合は、削除顧客の値をカラム名とともにメモに記載する
        memo_attribute_name = self.class.human_attribute_name(attribute_name)

        memo << "#{memo_attribute_name}：#{memo_integrate_value(attribute_name, integrate_value)}\n"
      end
    end

    if self.integrate_memo.present?
      self.integrate_memo << "\n\n"
    else
      self.integrate_memo = ''
    end

    self.integrate_memo << memo
  end

  def integrate_attribute_names
    attribute_names - INTEGRATE_EXCEPT_ATTRIBUTE_NAMES
  end

  def memo_integrate_value(attribute_name, value)
    return '' if value.blank? && value != false

    case attribute_name.to_sym
    when :can_receive_mail
      value ? '受け取る' : '受け取らない'

    when :has_registration_card
      value ? '済' : '未'

    # 日付変換
    when :birthday, :first_visited_at, :last_visited_at
      value.strftime('%Y/%m/%d')

    # 外部テーブルの値変換
    when :first_visit_store_id, :last_visit_store_id
      Store.find_by(id: value)&.name

    when :occupation_id, :zoomancy_id, :baby_age_id, :size_id, :visit_reason_id, :nearest_station_id
      model_name = attribute_name.to_s.gsub(/_id$/, '').camelize
      model_name.constantize.find_by(id: value)&.name

    else
      value
    end
  end
end
