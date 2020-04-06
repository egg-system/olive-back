class Observation < ApplicationRecord
  belongs_to :customer
  belongs_to :store
  belongs_to :staff
  belongs_to :menu

  attr_accessor :visit_date, :visit_time

  # square連携後に廃止する項目のため、中間テーブルを作らず簡易的に管理
  def options
    Option.where(id: self.option_ids.split(',')) if self.option_ids.present?
  end

  def option_names
    self.options.map(&:name)
  end

  def visit_date
    Date.parse(self.visit_datetime.strftime("%Y-%m-%d")) if self.visit_datetime.present?
  end

  def visit_time
    self.visit_datetime.strftime("%H:%M:%S") if self.visit_datetime.present?
  end
end
