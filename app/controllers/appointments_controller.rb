require 'pry'

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_service, only: [:index, :new, :create]

  # GET /appointments
  def index
    if (session[:user_id] != @service.user.id)
      @appointments = Appointment.all.order(:date, start_time: :desc)
    else
      @appointments = Appointment.where("user_id != null").order(:date, start_time: :desc)
      @available = Appointment.where("user_id = null").order(:date, start_time: :desc)
    end
  end

  # GET /appointments/1
  def show
  end

  def book
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
      "start_date(1i)", "start_date(2i)", "start_date(3i)", 
      "end_date(1i)", "end_date(2i)", "end_date(3i)", 
      "start_time(1i)", "start_time(2i)", "start_time(3i)",
      "start_time(4i)", "start_time(5i)", "end_time(1i)",
      "end_time(2i)", "end_time(3i)", "end_time(4i)", 
      "end_time(5i)", "duration"
    ]
    if !(appointment_params.keys - required_keys).empty?
      render :new
    end

    curr_date = Date.new(
      appointment_params["start_date(1i)"].to_i, 
      appointment_params["start_date(2i)"].to_i, 
      appointment_params["start_date(3i)"].to_i)
    end_date = Date.new(
      appointment_params["end_date(1i)"].to_i, 
      appointment_params["end_date(2i)"].to_i, 
      appointment_params["end_date(3i)"].to_i)
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
      
    while curr_date <= end_date
      curr_time = start_time
      while curr_time <= end_time
        @appointment_arr << Appointment.create(
          date: curr_date, start_time: curr_time,
          end_time: curr_time + appointment_params[:duration].to_i, 
          service_id: @service.id)
        curr_time += appointment_params[:duration].to_i*60
      end
      curr_date += 7*24*60*60
    end
    redirect_to service_appointments_url(@service), notice: 'Added appointments'
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_service
      @service = Service.find(params[:service_id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:start_date, :end_date, :start_time, :end_time, :duration, :service_id)
    end
end
