module ShiftBuildModule
  extend ActiveSupport::Concern

  included do
    has_many :reservation_shifts, dependent: :delete_all
    has_many :shifts, through: :reservation_shifts
    validates_presence_of :shifts, on: :create

    validate :validate_staff_shift, if: :should_validate?
  end

  def build_shifts
    # キャンセル済みの場合、シフトへの紐付け処理は実行しない
    return if self.canceled?

    self.end_time = extract_end_time_from_details
    treatable_shifts = Shift.where(date: self.reservation_date)
      .where(start_at: (self.start_time.to_s)...(self.end_time.to_s))
      .where(staff_id: extract_can_treat_staff_ids)
      .where(store_id: self.store_id)
      .where_not_reserved

    treatable_shifts = treatable_shifts.where(staff_id: self.staff_id) if self.staff_id.present?
    shifts = treatable_shifts.group_by { |shift| shift.staff.id }
      .select { |_staff_id, shifts_tmp| shifts_tmp.length === necessary_shift_count }
      .values
      .min_by { |shifts_tmp| shifts_tmp.first.staff.skill_staffs.length }

    return if shifts.nil?

    self.shifts = shifts
    self.staff = shifts.first.staff if self.staff_id.nil?
  end

  protected

  def necessary_shift_count
    reserved_duration = Tod::Shift.new(self.start_time, self.end_time).duration
    return reserved_duration / Shift::SLOT_INCREMENT_MITUNES.minutes.seconds
  end

  def should_validate?
    return self.staff_id.present? && !self.canceled?
  end

  def extract_can_treat_staff_ids
    menu_ids = self.reservation_details.map { |detail| detail.menu.id }
    option_ids = self.reservation_details.flat_map do |detail|
      detail.options.map { |option| option.id }
    end
    return Staff.can_treats(menu_ids, option_ids).map { |staff| staff.id }
  end

  def extract_end_time_from_details
    reservation_minutes = self.reservation_details.sum { |detail| detail.menu.service_minutes }
    return self.start_time + reservation_minutes.minutes unless self.start_time.nil?
  end

  def validate_staff_shift
    if self.shifts.empty?
      errors.add(:staff_id, 'は対応できません。日時、または担当者を変更してください。')
    end

    if self.shifts.any? { |shift| shift.staff_id != self.staff_id }
      errors.add(:staff_id, '異常データが検知されました。')
    end
  end
end
