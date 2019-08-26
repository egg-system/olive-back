class ApplicationController < ActionController::Base
  before_action :authenticate_staff!, :set_host
  protect_from_forgery with: :exception

  def after_sign_out_path_for(resource)
    new_staff_session_path
  end

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  protected

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
    return Staff.where_store_id(store_ids).uniq
  end
end
