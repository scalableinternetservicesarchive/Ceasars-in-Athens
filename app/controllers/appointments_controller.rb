require 'pry'

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  def index
    @service = Service.find(params[:service_id])
    @appointments = Appointment.all
  end

  # GET /appointments/1
  def show
  end

  def book
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # Create Service
  def create
    @appointment_arr = []
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
          service_id: appointment_params[:service_id].to_i)
        curr_time += appointment_params[:duration].to_i*60
        binding.pry
      end
      curr_date += 7*24*60*60
    end

    render :new
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

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:start_date, :end_date, :start_time, :end_time, :duration, :service_id)
    end
end
