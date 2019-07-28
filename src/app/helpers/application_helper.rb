# frozen_string_literal: true

module ApplicationHelper
  def home_path
    return root_path if staff_signed_in?

    new_staff_session_path
  end

  def production?
    request.host === Settings.domain.production
  end

  def bg_color
    production? ? 'bg-primary' : 'bg-warning'
  end
end
