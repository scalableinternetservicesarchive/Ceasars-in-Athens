module ApplicationHelper
  def flash_class(level)
      case level.to_sym
          when :notice then "alert alert-primary"
          when :success then "alert alert-success"
          when :error then "alert alert-danger"
      end
  end

  def require_login
    if current_user.nil?
      flash[:notice] = "Login required for this action"
      redirect_to login_path    
    end

  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
