class ApplicationController < ActionController::Base
  caches_page :show, :new
  include ApplicationHelper
  skip_forgery_protection
end
