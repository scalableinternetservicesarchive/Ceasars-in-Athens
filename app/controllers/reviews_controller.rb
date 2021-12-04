require 'pry'
class ReviewsController < ApplicationController
  include Pagy::Backend

  before_action :set_review, only: [:show, :destroy]
  before_action :set_service, only: [:index, :new, :create]
  before_action :require_login, only: [:index, :destroy, :new]
  before_action :require_ownership, only: [:destroy]

  # GET /services/1/reviews
  def index
    if params[:service_id]
      @pagy, @reviews = pagy(Review.where(service_id: params[:service_id]).order(created_at: :desc).all)
    else
      redirect_to root_path, alert: "Invalid service selected"
    end
  end

  # GET /services/1/reviews/new
  def new
    @review = Review.new
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.user_name = current_user.username
    @review.service_id = @service.id

    if @review.save
      redirect_to service_reviews_url(@service), notice: 'Added reviews'
    else
      render :new
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
    redirect_to request.referer, notice: 'Review was successfully deleted.'
  end

  private
    def require_ownership 
      if @review.user_id != session[:user_id]
        flash[:error] = "Can only edit your own review"
        redirect_to @review
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_service
      @service = Service.find(params[:service_id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:service_id, :user_id, :rating, :review)
    end
end
