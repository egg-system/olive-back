module ReservationsHelper
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

  def cancel_confirm_message(reservation)
    message = '本当にキャンセルしますか？'
    return message unless reservation.email_present?

    return "#{message}\nまた、キャンセルメールを送信有無を再度ご確認ください。"
  end
end
