class VisitStoreValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return unless value

    record.errors.add(:visit_store_ids, :blank) if (value - ['', nil]).blank?
  end
end
