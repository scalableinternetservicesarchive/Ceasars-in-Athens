require 'pry'
class ReviewsController < ApplicationController
  include Pagy::Backend

  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_service, only: [:index, :new, :create]

  # GET /reviews
  def index
    @reviews = Review.order(created_at: :desc).all
  end

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    @review_arr = []
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)
    @review.user_id = session[:user_id]
    @review.service_id = @service.id

    if @review.save
      redirect_to service_reviews_url(@service), notice: 'Added reviews'
    else
      render :new
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
    redirect_to reviews_url, notice: 'Review was successfully destroyed.'
  end

  private
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
