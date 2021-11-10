require 'pry'
class AuthenticationController < ApplicationController
    # skip_before_action :authorize_request, only: [:authenticate, :authorize_request]
    # return auth token once user is authenticated
    def authenticate
      auth_token =
        AuthenticateUser.new(auth_params[:username], auth_params[:password]).call
      json_response(auth_token: auth_token)
    end
  
    def get_user
      binding.pry
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
      json_response(@current_user)
      # do not authorize request for now
    end
  
    private
  
    def auth_params
      params.permit(:username, :password)
    end
  end