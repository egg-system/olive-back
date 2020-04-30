class FullWidthKanaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || I18n.t('errors.messages.not_full_width_kana')) if value.present? && value !~ /\A[ァ-ヶー－]+\z/
  end
end
