# frozen_string_literal: true

module ShiftBuildModule
  extend ActiveSupport::Concern

  included do
    has_many :reservation_shifts, dependent: :delete_all
    has_many :shifts, through: :reservation_shifts
    validates :shifts, presence: { on: :create }

    validate :validate_staff_shift, if: :should_validate?
  end

  def build_shifts
    # キャンセル済みの場合、シフトへの紐付け処理は実行しない
    return if canceled?

    self.end_time = extract_end_time_from_details
    treatable_shifts = Shift.where(date: reservation_date)
                            .where(start_at: (start_time.to_s)...(end_time.to_s))
                            .where(staff_id: extract_can_treat_staff_ids)
                            .where(store_id: store_id)
                            .where_not_reserved

    treatable_shifts = treatable_shifts.where(staff_id: staff_id) if staff_id.present?
    shifts = treatable_shifts.group_by { |shift| shift.staff.id }
                             .select { |_staff_id, shifts| shifts.length === necessary_shift_count }
                             .values
                             .min_by { |shifts| shifts.first.staff.skill_staffs.length }

    return if shifts.nil?

    self.shifts = shifts
    self.staff = shifts.first.staff if staff_id.nil?
  end

  protected

  def necessary_shift_count
    reserved_duration = Tod::Shift.new(start_time, end_time).duration
    reserved_duration / Shift::SLOT_INCREMENT_MITUNES.minutes.seconds
  end

  def should_validate?
    staff_id.present? && !canceled?
  end

  def extract_can_treat_staff_ids
    menu_ids = reservation_details.map { |detail| detail.menu.id }
    option_ids = reservation_details.flat_map do |detail|
      detail.options.map(&:id)
    end
    Staff.can_treats(menu_ids, option_ids).map(&:id)
  end

  def extract_end_time_from_details
    reservation_minutes = reservation_details.sum { |detail| detail.menu.service_minutes }
    return start_time + reservation_minutes.minutes unless start_time.nil?
  end

  def validate_staff_shift
    errors.add(:staff_id, 'は対応できません。日時、または担当者を変更してください。') if shifts.empty?

    if shifts.any? { |shift| shift.staff_id != staff_id }
      errors.add(:staff_id, '異常データが検知されました。')
    end
  end
end
