class VisitStoreValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    if(value)
      record.errors.add(:visit_store_ids, :blank) if (value - ['', nil]).blank?
    end
  end
end
