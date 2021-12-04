class ServicesController < ApplicationController
  include Pagy::Backend

  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :edit, :new]
  before_action :require_ownership, only: [:update, :edit, :destroy]

  # GET /services
  def index
    if params[:owned].present? 
      if session[:user_id].present?
        @all_services = false
        @pagy, @services = pagy(Service.where(user_id: session[:user_id]).order(created_at: :desc).all)
      else
        flash[:error] = "Must be logged in to see owned services"
        render :index
      end
    else
      @all_services = true
      @pagy, @services = pagy(Service.includes(:user).order(created_at: :desc).all)
    end
  end

  # GET /services/1
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  def create
    @service = Service.new(service_params)
    @service.user_id = session[:user_id]
    @service.user_name = Users.find(session[:user_id]).username

    if @service.save
      redirect_to @service, notice: 'Created service'
    else
      render :new
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Updated service'
    else
      render :edit
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    redirect_to services_url, notice: 'Deleted service'
  end

  private
    def require_ownership 
      if @service.user_id != session[:user_id]
        flash[:error] = "Can only edit your own services"
        redirect_to @service
      end
    end

    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:title, :description, :zipcode, :length_of_time, :user_id)
    end
end
