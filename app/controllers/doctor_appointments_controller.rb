class DoctorAppointmentsController < ApplicationController
  before_action :set_doctor_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_doctors_and_users, only: [:new, :edit]
  before_action :set_doctor_user_from_session, only: [:index, :new]

  # GET /doctor_appointments
  # GET /doctor_appointments.json
  def index
    if @doctor && @user
      @doctor_appointments = DoctorAppointment.where(user_id: @user.id, doctor_id: @doctor.id)
    elsif @user
      @doctor_appointments = DoctorAppointment.where(user_id: @user.id)
    elsif @doctor
      @doctor_appointments = DoctorAppointment.where(doctor_id: @doctor.id)
    else
      @doctor_appointments = DoctorAppointment.all
    end
  end

  # GET /doctor_appointments/1
  # GET /doctor_appointments/1.json
  def show
  end

  # GET /doctor_appointments/new
  def new
    @doctor_appointment = DoctorAppointment.new
  end

  # GET /doctor_appointments/1/edit
  def edit
  end

  # POST /doctor_appointments
  # POST /doctor_appointments.json
  def create
    @doctor_appointment = DoctorAppointment.new(doctor_appointment_params)

    respond_to do |format|
      if @doctor_appointment.save
        format.html { redirect_to @doctor_appointment, notice: 'Doctor appointment was successfully created.' }
        format.json { render :show, status: :created, location: @doctor_appointment }
      else
        format.html { render :new }
        format.json { render json: @doctor_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctor_appointments/1
  # PATCH/PUT /doctor_appointments/1.json
  def update
    respond_to do |format|
      if @doctor_appointment.update(doctor_appointment_params)
        format.html { redirect_to @doctor_appointment, notice: 'Doctor appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor_appointment }
      else
        format.html { render :edit }
        format.json { render json: @doctor_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctor_appointments/1
  # DELETE /doctor_appointments/1.json
  def destroy
    @doctor_appointment.destroy
    respond_to do |format|
      format.html { redirect_to doctor_appointments_url, notice: 'Doctor appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor_appointment
      @doctor_appointment = DoctorAppointment.find(params[:id])
    end

    def set_doctors_and_users
      @doctors = Doctor.all
      @users = User.all
    end

    def set_doctor_user_from_session
      #initialise ids
      doctor_id = nil
      user_id = nil

      # find user
      if session[:user_id]
        user_id = session[:user_id]
      elsif request.query_parameters['userId']
        user_id = request.query_parameters['userId']
      end
      if user_id
        @user = User.find(user_id)
      end

      # find doctor
      if session[:doctor_id]
        doctor_id = session[:doctor_id]
      elsif request.query_parameters['doctorId']
        doctor_id = request.query_parameters['doctorId']
      end
      if doctor_id
        @doctor = Doctor.find(doctor_id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_appointment_params
      params.require(:doctor_appointment).permit(:description, :from, :to, :doctor_id, :user_id)
    end
end
