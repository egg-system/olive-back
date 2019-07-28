# frozen_string_literal: true

module ReservationAuditModule
  extend ActiveSupport::Concern

  included do
    thread_mattr_accessor :audited_staff
    after_update :update_audtis
  end

  def created_audit
    audits.where(action: 'create').first
  end

  def canceled_audit
    audits
      .where(action: 'update')
      .where('audited_changes like ?', '%canceled_at%')
      .first
  end

  def created_by
    audit_value(created_audit)
  end

  def canceled_by
    audit_value(canceled_audit)
  end

  def audit_value(audit)
    return nil if audit.nil?

    # 画面から変更した履歴の実行者は文字列(username)になる
    return audit.username if can_update_audit(audit)

    audit.user_type
  end

  def created_by=(created_by)
    return unless can_update_created_by?

    @created_audit = created_audit
    @created_audit = build_created_audit if @created_audit.nil?
    @created_audit.user = created_by
  end

  def canceled_by=(canceled_by)
    return unless can_update_canceled_by?

    @canceled_audit = canceled_audit
    @canceled_audit = build_canceled_audit if @canceled_audit.nil?
    @canceled_audit.user = canceled_by
  end

  def can_update_created_by?
    can_update_audit(created_audit)
  end

  def can_update_canceled_by?
    can_update_audit(canceled_audit)
  end

  def can_update_audit(audit)
    return false if new_record?
    return true if audit.nil?

    audit.user.is_a?(String)
  end

  def update_audtis
    @created_audit&.save
    @canceled_audit&.save
  end

  def build_created_audit
    audits.build(
      action: 'create',
      created_at: created_at
    )
  end

  def build_canceled_audit
    audits.build(
      action: 'update',
      audited_changes: { canceled_at: [nil, canceled_at] },
      created_at: canceled_at
    )
  end
end
