module ReservationsHelper
  def mimitsubo_jwery_options
    ReservationDetail::MIMITSUBO_JEWELRY_OPTIONS.map { |option| ["#{option}粒", option] }
  end

  def create_audit(reservation = @reservation)
    return reservation.audits.where(action: 'create').first
  end

  def cancel_audit(reservation = @reservation)
    return reservation.audits
      .where(action: 'update')
      .where('audited_changes like ?', 'canceled_at')
      .first
  end

  def cancel_audit_log(reservation = @reservation)
    audit = cancel_audit(reservation)
    return nil if audit.nil?

    user_type = audit.user_type === 'Staff' ? 'スタッフ' : '顧客'
    date = audit.created_at.strftime('%Y/%m/%d %H:%M')
    return "#{user_type}が、#{date}にキャンセル"
  end

  def create_audit_log(reservation = @reservation)
    audit = create_audit(reservation)
    return nil if audit.nil?

    user_type = audit.user_type === 'Staff' ? 'スタッフ' : '顧客'
    date = audit.created_at.strftime('%Y/%m/%d %H:%M')
    return "#{user_type}が、#{date}に登録"
  end
end
