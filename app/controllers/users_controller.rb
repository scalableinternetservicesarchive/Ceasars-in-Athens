require 'pry'
class UsersController < ApplicationController
  # skip_before_action :authorize_request, only: :create

  # POST /api/signup
  # return authenticated token at signup
  def create
    params = user_params
    if (params['password'] != params['password_confirmation'])
      return json_response({message: 'The passwords do not match.'}, :bad_request)
    end
    begin
      user = User.create!(params)
    rescue ActiveRecord::RecordNotUnique => e
      return json_response({ message: 'That username is taken.'}, :forbidden)
    end
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end


  private
    def user_params
      binding.pry
      params.permit(:username, :password, :password_confirmation)
    end
end