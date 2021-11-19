include Pagy::Backend

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:update, :destroy]
  before_action :set_service, only: [:new, :create, :destroy, :update]
  before_action :require_login, only: [:index, :update, :destroy, :new]
  before_action :require_ownership, only: [:update, :destroy]
  before_action :require_service_ownership, only: [:new, :create]

  # GET /appointments
  def index
    now = Time.now
    if params[:service_id] != nil
      set_service()
      # Available appointments to book
      @pagy_appointments, @appointments = pagy(
        Appointment
          .where(user_id: nil, service_id: @service.id)
          .where('start_time >= ?', now)
          .order(:date, :start_time),
        page_param: :page_appts
      )
      # Appointments already booked by clients
      @pagy_booked, @booked = pagy(
        Appointment
          .where(service_id: @service.id)
          .where.not(user_id: nil)
          .where('start_time >= ?', now)
          .order(:date, :start_time),
        page_param: :page_booked
      )
    elsif params[:view] == "provider"
      # Available appointment slots for services belonging to user
      @pagy_appointments, @appointments = pagy(
        Appointment
          .where(user_id: nil)
          .includes(:service)
          .references(:service)
          .where('services.user_id = ?', session[:user_id])
          .where('start_time >= ?', now)
          .order("appointments.date", "appointments.start_time"),
        page_param: :page_appts
      )
      # Appointments to services belonging to the current user
      @pagy_booked, @booked = pagy(
        Appointment
          .where.not(user_id: nil)
          .includes(:service)
          .references(:service)
          .where('services.user_id = ?', session[:user_id])
          .where('start_time >= ?', now)
          .order("appointments.date", "appointments.start_time"),
        page_param: :page_booked
      )
    else 
      # Appointments that the current user has made
      @pagy_appointments_future, @appointments_future = pagy(
        Appointment
          .where(user_id: session[:user_id])
          .where('start_time >= ?', now)
          .order(:date, :start_time),
        page_param: :page_appts_future
      )
      @pagy_appointments_past, @appointments_past = pagy(
        Appointment
          .where(user_id: session[:user_id])
          .where('start_time < ?', now)
          .order(date: :desc, start_time: :desc),
        page_param: :page_appts_past
      )
    end
  end

  # GET /appointments/new
  def new 
    @appointment_builder = AppointmentBuilder.new
  end


  # POST /appointments
  def create
    @appointments=[]
    @appointment_builder = AppointmentBuilder.new(appointment_builder_params)
    if !(@appointment_builder.valid?)
      render :new
      return
    end

    date = Time.parse(appointment_builder_params[:date], "%Y-%m-%d")
    duration_mins = appointment_builder_params[:duration].to_i * 60

    start_h, start_m = appointment_builder_params[:start_time].split('.').map(&:to_i)
    end_h, end_m = appointment_builder_params[:end_time].split('.').map(&:to_i)

    start_time = date.change({hour: start_h, min: start_m}) + 8*60*60
    end_time = date.change({hour: end_h, min: end_m}) + 8*60*60

    # @appointment_arr.errors.add(:date, "wasn't filled in")
    # redirect_to service_appointments_url(@service), error: 'Test'

    curr_time = start_time
    while curr_time <= end_time - duration_mins
      appt = Appointment.new(
        date: curr_time,
        start_time: curr_time,
        end_time: curr_time + duration_mins,
        service_id: @service.id
      )
      @appointments << appt
      if !appt.save
        @appointment_builder.errors.merge!(appt)
      end
      curr_time += duration_mins
    end
    # render json: @appointments
    if @appointment_builder.errors.empty?
      redirect_to service_appointments_url(@service), notice: 'Added appointment slots'
    else
      render :new
    end
  end

  # PATCH/PUT /appointments/1
  def update
    case params[:do_action]
      in "decline"
        # Service provider declines a user's appointment, provider redirected to original page
        @appointment.update(user_id: nil)
        redirect_to request.referer, notice: 'Appointment was declined.'
      in "cancel"
        # User cancels an appointment, user redirected to My appointments page
        @appointment.update(user_id: nil)
        redirect_to appointments_url, notice: 'Appointment was canceled.'
      in "book"
        @appointment.update(user_id: session[:user_id])
        if (params[:reschedule] != nil)
          appointment = Appointment.find(params[:reschedule])
          appointment.update(user_id: nil)
        end
        redirect_to appointments_url, notice: 'Appointment was successfully booked.'
    else
      flash[:error] = "Invalid action"
      redirect_to request.referer
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    redirect_to request.referer, notice: 'Appointment was successfully deleted.'
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
      if params[:do_action] != 'book' && 
        @service.user_id != session[:user_id] && 
        @appointment.user_id != session[:user_id]
        flash[:error] = "Cannot cancel others' appointments"
        redirect_to request.referer
      end
    end

    def require_service_ownership 
      if @service.user_id != session[:user_id] 
        flash[:error] = "Can only edit your own services"
        redirect_to @service
      end
    end

    # Only allow a list of trusted parameters through.
    def appointment_builder_params
      params.require(:appointment_builder).permit(:date, :start_time, :end_time, :duration)
    end
end
