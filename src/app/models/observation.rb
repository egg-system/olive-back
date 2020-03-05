class Observation < ApplicationRecord
  include PaginationModule

  belongs_to :store
  belongs_to :staff
  belongs_to :menu

  def options
    Option.where(id: self.option_ids.split(',')) if self.option_ids.present?
  end

  def option_names
    return self.options.map { |option|
      option_name = option.name

      # 耳つぼジュエリの個数を表記するための実装
      if option.is_mimitsubo_jewelry
        option_name = "#{option.name} × #{self.mimitsubo_count.to_s}個"
      end

      option_name
    }
  end
end
