class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Registered new account'
    else
      render :new
    end
  end


  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
