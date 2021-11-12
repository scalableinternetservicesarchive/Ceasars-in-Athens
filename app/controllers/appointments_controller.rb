require 'pry'

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_service, only: [:new, :create, :destroy, :update]
  before_action :require_login, only: [:index, :update, :destroy, :edit, :new]
  before_action :require_ownership, only: [:update, :destroy]
  before_action :require_service_ownership, only: [:new, :create]

  # GET /appointments
  def index
    if params[:service_id] != nil
      set_service()
      @appointments = Appointment.where(user_id: nil, service_id: @service.id)
        .order(:date, start_time: :desc)
      @booked = Appointment.where(user_id: true, service_id: @service.id)
        .order(:date, start_time: :desc)
    else
      @appointments = Appointment.where(user_id: session[:user_id]).order(:date, start_time: :desc)
      @booked = Appointment.select('"appointments".*, "services"."user_id"')
        .joins('FULL OUTER JOIN "services" ON "services"."id" = "appointments"."service_id"')
        .where("\"services\".\"user_id\" = #{session[:user_id]} AND \"appointments\".\"user_id\" IS NOT NULL")
    end
  end

  # GET /appointments/1
  def show
  end

  # GET /appointments/new
  def new
    @appointment_arr = []
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  def create
    @appointment_arr = []

    required_keys = [
      "date(1i)", "date(2i)", "date(3i)", 
      "start_time(1i)", "start_time(2i)", "start_time(3i)",
      "start_time(4i)", "start_time(5i)", "end_time(1i)",
      "end_time(2i)", "end_time(3i)", "end_time(4i)", 
      "end_time(5i)", "duration"
    ]
    if !(appointment_params.keys - required_keys).empty?
      render :new
    end

    date = Date.new(
      appointment_params["date(1i)"].to_i, 
      appointment_params["date(2i)"].to_i, 
      appointment_params["date(3i)"].to_i)
    start_time = Time.new(
      appointment_params["start_time(1i)"].to_i, 
      appointment_params["start_time(2i)"].to_i, 
      appointment_params["start_time(3i)"].to_i,
      appointment_params["start_time(4i)"].to_i, 
      appointment_params["start_time(5i)"].to_i
    )
    end_time = Time.new(
      appointment_params["end_time(1i)"].to_i, 
      appointment_params["end_time(2i)"].to_i, 
      appointment_params["end_time(3i)"].to_i,
      appointment_params["end_time(4i)"].to_i, 
      appointment_params["end_time(5i)"].to_i
    )
      
    curr_time = start_time
    while curr_time <= end_time
      @appointment_arr << Appointment.create(
        date: date, start_time: curr_time,
        end_time: curr_time + appointment_params[:duration].to_i*60, 
        service_id: @service.id)
      curr_time += appointment_params[:duration].to_i*60
    end
    redirect_to service_appointments_url(@service), notice: 'Added appointment slots'
  end

  # PATCH/PUT /appointments/1
  def update
    if params[:do_action] == "decline" && @appointment.update(user_id: nil)
      redirect_to service_appointments_url(@service), notice: 'Appointment was declined.'
    elsif params[:do_action] == "cancel" && @appointment.update(user_id: nil)
      redirect_to appointments_url, notice: 'Appointment was canceled.'
    elsif @appointment.update(user_id: session[:user_id])
      redirect_to appointments_url, notice: 'Appointment was successfully booked.'
    else
      redirect_to @service, notice: 'Appointment booking failed.'
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    redirect_to service_appointments_url(@service), notice: 'Appointment was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_service
      @service = Service.find(params[:service_id])
    end

    def require_ownership
    end

    def require_service_ownership 
      if @service.user_id != session[:user_id] 
        flash[:error] = "Can only edit your own services"
        redirect_to @service
      end
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:date, :start_time, :end_time, :duration, :service_id)
    end
end
