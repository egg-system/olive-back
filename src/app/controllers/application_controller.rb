class ApplicationController < ActionController::Base
  before_action :authenticate_staff!, :set_host
  before_action :authenticate_store! if :staff_signed_in?
  protect_from_forgery with: :exception
  rescue_from Exception, with: :render500 if Rails.env.production?

  def after_sign_out_path_for(resource)
    new_staff_session_path
  end

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  protected

  def authenticate_store!
    if controller_path.start_with?('api') && !controller_path.start_with?('api/admin')
      return
    end

    # ログイン処理時にエラーになるため、return
    return if controller_path === 'staffs/sessions' && action_name === 'create'

    # ログアウト処理時にエラーになるため、return
    return if current_staff.nil?

    is_belongs_login_store = current_staff.stores.any? {
      |store| store.id === view_context.current_store.id
    }

    # 所属店舗の変更をチェックする
    unless is_belongs_login_store
      sign_out
      redirect_to(
        staff_session_url,
        notice: '所属店舗が変更されました。お手数ですが、再度ログインしてください。'
      )
    end
  end

  def forbidden_unless_admin
    head :forbidden unless current_staff.role.admin?
  end

  def audited_user
    return current_staff if staff_signed_in?
  end

  # 権限に応じて、閲覧可能な店舗を取得する
  def viewable_stores
    return Store.all if current_staff.role.admin?

    return Store.viewable?(view_context.current_store)
  end

  # 店舗に応じたスタッフを選択可能にする
  def viewable_staffs
    store_ids = viewable_stores.pluck(:id)
    return Staff.where_store_id(store_ids).distinct
  end

  def viewable_staffs_exclude_hidden
    return viewable_staffs.exclude_hidden
  end

  # 管理者のみ管理者権限に変更できるようにする
  def viewable_roles
    return Role.all if current_staff.role.admin?

    return Role.viewable?(view_context.current_store)
  end

  def render500(exception)
    ExceptionNotifier.notify_exception(
      exception,
      :env => request.env,
      :data => { :message => 'error' }
    )

    render(
      file: Rails.root.join('public/500.html'),
      status: 500,
      layout: false,
      content_type: 'text/html'
    )
  end
end
