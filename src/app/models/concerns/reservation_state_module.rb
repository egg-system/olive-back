module ReservationStateModule
  extend ActiveSupport::Concern

  STATES = {
    reserved: '予約中',
    visited: '来店済み',
    canceled: 'キャンセル済み'
  }.freeze

  included do
    extend ReservationStateModule::ClassMethods

    scope :where_state, ->(state) {
      case state.to_sym
      when :canceled
        return where.not(canceled_at: nil)
      when :reserved
        return where(
          'reservation_date > ? or (reservation_date = ? and start_time > ?)',
          Date.today,
          Date.today,
          Time.now
        ).where(canceled_at: nil)
      when :visited
        return where(
          'reservation_date <= ? or (reservation_date = ? and start_time <= ?)',
          Date.today,
          Date.today,
          Time.now
        ).where(canceled_at: nil)
      end
    }
  end

  module ClassMethods
    def states
      return STATES.invert
    end
  end

  def state_symbol
    return :canceled if self.canceled?

    reservation_end_at = self.end_time.on(self.reservation_date)
    visited = reservation_end_at < DateTime.now
    return visited ? :visited : :reserved
  end

  def state
    return STATES[self.state_symbol]
  end
end
