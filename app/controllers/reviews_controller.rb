class ReviewsController < ApplicationController
  include Pagy::Backend

  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :edit, :new]
  before_action :require_ownership, only: [:update, :edit, :destroy]

  # GET /reviews
  def index
    @pagy, @reviews = pagy(Review.order(created_at: :desc).all)
  end

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)
    @review.user_id = session[:user_id]
    @review.service_id = session[:service_id]

    if @review.save
      redirect_to @review, notice: 'Review was successfully created.'
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

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:service_id, :user_id, :rating, :review)
    end
end
