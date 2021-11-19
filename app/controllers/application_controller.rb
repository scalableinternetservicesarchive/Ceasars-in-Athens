# require 'pry'
class ApplicationController < ActionController::Base
  include ApplicationHelper
  skip_forgery_protection

  before_action :set_cache_headers

  private

  def set_cache_headers
    # binding.pry
    response.headers["Cache-Control"] = "public"
    # response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 2022 00:00:00 GMT"
  end

end
