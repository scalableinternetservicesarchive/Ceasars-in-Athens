class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  # GET /availabilities
  def index
    @availabilities = Availability.all
  end

  # GET /availabilities/1
  def show
  end

  # GET /availabilities/new
  def new
    @availability = Availability.new
  end

  # GET /availabilities/1/edit
  def edit
  end

  # POST /availabilities
  def create
    @availability = Availability.new(availability_params)

    if @availability.save
      redirect_to @availability, notice: 'Availability was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /availabilities/1
  def update
    if @availability.update(availability_params)
      redirect_to @availability, notice: 'Availability was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /availabilities/1
  def destroy
    @availability.destroy
    redirect_to availabilities_url, notice: 'Availability was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.require(:availability).permit(:user_id, :start, :end, :is_available, :is_recurring)
    end
end
