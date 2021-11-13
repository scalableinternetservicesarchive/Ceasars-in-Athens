class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:login][:username])
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in. Welcome #{params[:login][:username]}"
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
