class HalfWidthDigitValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && value !~ /\A[0-9]+\z/
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.not_half_width_digit'))
    end
  end
end
