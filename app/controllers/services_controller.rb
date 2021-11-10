class ServicesController < ApplicationController
  include Pagy::Backend

  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :edit, :new]
  before_action :require_ownership, only: [:update, :edit, :destroy]

  # GET /services
  def index
    # @pagy, @services = pagy(Service.order(created_at: :desc).all)
    @services = Service.select('"services".*, "users"."username"')
        .joins('FULL OUTER JOIN "users" ON "users"."id" = "services"."user_id"')
        .order(created_at: :desc)

    if (params[:user_id] != nil)
      @services = @services.where({user_id: params[:user_id]})
    end

    render json: @services, status: 200
  end

  # GET /services/1
  def show
    @service = Service.find(params[:id])
    @username = User.find(@service.user_id).username
    render json: {service: @service, username: @username}, status: 200
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
    render status:200
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
