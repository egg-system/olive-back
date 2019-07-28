# frozen_string_literal: true

class FullWidthKanaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && value !~ /\A[ァ-ヶー－]+\z/
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.not_full_width_kana'))
    end
  end
end
