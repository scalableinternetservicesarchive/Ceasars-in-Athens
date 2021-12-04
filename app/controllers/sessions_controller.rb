class SessionsController < ApplicationController
  def new
  end

  def create
    login_params = params.require(:login).permit(:username, :password)
    user = User.find_by(username: login_params[:username])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.username
      flash[:success] = "Logged in. Welcome #{login_params[:username]}"
      redirect_to root_path
    else
      flash.now[:error] = "Invalid credentials"      
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "Logged out"
    redirect_to login_path
  end

end
