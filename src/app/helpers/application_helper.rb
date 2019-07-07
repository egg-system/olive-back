module ApplicationHelper
  def home_path()
    if staff_signed_in?
      return root_path 
    end

    return new_staff_session_path
  end

  def production?
    request.host === Settings.domain.production
  end

  def bg_color
    production? ? 'bg-primary' : 'bg-warning'
  end
end
