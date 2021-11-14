class ApplicationController < ActionController::Base
  include ApplicationHelper
  skip_forgery_protection
end
