module ReservationAuditModule
  extend ActiveSupport::Concern

  included do
    thread_mattr_accessor :audited_staff
    after_update :update_audtis
  end

  def created_audit
    self.audits.where(action: 'create').first
  end

  def canceled_audit
    self.audits
      .where(action: 'update')
      .where("audited_changes like ?", '%canceled_at%')
      .first
  end

  def created_by
    return audit_value(created_audit)
  end

  def created_at_string
    return self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def canceled_by
    return audit_value(canceled_audit)
  end

  def audit_value(audit)
    return nil if audit.nil?

    # 画面から変更した履歴の実行者は文字列(username)になる
    return audit.username if can_update_audit(audit)

    return audit.user_type
  end

  def created_by=created_by
    return unless can_update_created_by?

    @created_audit = created_audit
    @created_audit = self.build_created_audit if @created_audit.nil?
    @created_audit.user = created_by
  end

  def canceled_by=canceled_by
    return unless can_update_canceled_by?

    @canceled_audit = canceled_audit
    @canceled_audit = self.build_canceled_audit if @canceled_audit.nil?
    @canceled_audit.user = canceled_by
  end

  def can_update_created_by?
    can_update_audit(created_audit)
  end

  def can_update_canceled_by?
    can_update_audit(canceled_audit)
  end

  def can_update_audit(audit)
    return false if self.new_record?
    return true if audit.nil?

    return audit.user.is_a?(String)
  end

  def update_audtis
    @created_audit.save unless @created_audit.nil?
    @canceled_audit.save unless @canceled_audit.nil?
  end

  def build_created_audit
    return self.audits.build(
      action: 'create',
      created_at: self.created_at
    )
  end

  def build_canceled_audit
    return self.audits.build(
      action: 'update',
      audited_changes: { canceled_at: [nil, self.canceled_at] },
      created_at: self.canceled_at
    )
  end
end
