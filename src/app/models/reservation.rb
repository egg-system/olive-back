class Reservation < ApplicationRecord
    require 'tod'
  
    # time型を扱いやすくするための実装
    serialize :start_time, Tod::TimeOfDay
    serialize :end_time, Tod::TimeOfDay

    acts_as_paranoid

    extend DateModule
    include PaginationModule

    belongs_to :customer
    belongs_to :pregnant_state, optional: true
    
    has_many :reservation_details
    accepts_nested_attributes_for :reservation_details
    validates_presence_of :reservation_details
        
    has_many :reservation_coupons
    has_many :coupons, through: :reservation_coupons
    accepts_nested_attributes_for :reservation_coupons, allow_destroy: true

    has_many :reservation_shifts
    has_many :shifts, through: :reservation_shifts
    validates_presence_of :reservation_shifts

    after_commit :send_confirm_mail, on: :create

    scope :order_reserved_at, -> {
      order(reservation_date: :desc)
      .order(start_time: :desc)
    }

    def build_shifts
        self.end_time = extract_end_time_from_details
        shifts = Shift
            .where(date: self.reservation_date)
            .where(start_at: (self.start_time.to_s)...(self.end_time.to_s))
            .where(staff_id: extract_can_treat_staff_ids)
            .where_not_reserved
        
        return if shifts.empty?
        self.shifts = shifts.group_by { |shift| shift.staff_id }.values.first  
    end

    private

    def extract_can_treat_staff_ids
        menu_ids = self.reservation_details
            .map { |reservation_detail| reservation_detail.menu.id }
        option_ids = self.reservation_details.flat_map { |reservation_detail| 
            reservation_detail.options.map { |option| option.id }  
        }
        return Staff.can_treats(menu_ids, option_ids).map { |staff| staff.id }
    end

    def extract_end_time_from_details
        reservation_minutes = self.reservation_details
            .sum { |reservation_detail| reservation_detail.menu.service_minutes }
        return self.start_time + reservation_minutes.minutes unless self.start_time.nil? 
    end
    
    def send_confirm_mail
        ReservationMailer.confirm_reservation(self).deliver_now
    end
end
