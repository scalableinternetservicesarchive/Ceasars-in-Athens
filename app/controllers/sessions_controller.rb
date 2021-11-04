class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:login][:username])
    if user && user.authenticate(params[:login][:password])
      session[:username] = user.username
      redirect_to root_path, notice: 'Successfully logged in'
    else
      flash.now[:alert] = "Invalid credentials"      
      render :new
    end
  end

  def destroy
    session.delete(:username)
    redirect_to login_path
  end

end
