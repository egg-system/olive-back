module ApplicationHelper
  def home_path()
    if user_signed_in?
      return root_path 
    end

    return new_user_session_path
  end
end
