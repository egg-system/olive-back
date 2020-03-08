class Observation < ApplicationRecord
  include PaginationModule

  belongs_to :store
  belongs_to :staff
  belongs_to :menu

  def options
    Option.where(id: self.option_ids.split(',')) if self.option_ids.present?
  end

  def option_names
    self.options.map(&:name)
  end
end
