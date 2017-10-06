class DoctorNotificationsController < ApplicationController
  before_action :set_doctor_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_doctors_and_users, only: [:new, :edit]

  # GET /doctor_notifications
  # GET /doctor_notifications.json
  def index
    @doctor_notifications = DoctorNotification.all
  end

  # GET /doctor_notifications/1
  # GET /doctor_notifications/1.json
  def show
  end

  # GET /doctor_notifications/new
  def new
    @doctor_notification = DoctorNotification.new
  end

  # GET /doctor_notifications/1/edit
  def edit
  end

  # POST /doctor_notifications
  # POST /doctor_notifications.json
  def create
    @doctor_notification = DoctorNotification.new(doctor_notification_params)

    respond_to do |format|
      if @doctor_notification.save
        format.html { redirect_to @doctor_notification, notice: 'Doctor notification was successfully created.' }
        format.json { render :show, status: :created, location: @doctor_notification }
      else
        format.html { render :new }
        format.json { render json: @doctor_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctor_notifications/1
  # PATCH/PUT /doctor_notifications/1.json
  def update
    respond_to do |format|
      if @doctor_notification.update(doctor_notification_params)
        format.html { redirect_to @doctor_notification, notice: 'Doctor notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor_notification }
      else
        format.html { render :edit }
        format.json { render json: @doctor_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctor_notifications/1
  # DELETE /doctor_notifications/1.json
  def destroy
    @doctor_notification.destroy
    respond_to do |format|
      format.html { redirect_to doctor_notifications_url, notice: 'Doctor notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor_notification
      @doctor_notification = DoctorNotification.find(params[:id])
    end

    def set_doctors_and_users
      @doctors = Doctor.all
      @users = User.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_notification_params
      params.require(:doctor_notification).permit(:title, :user_id, :doctor_id, :notified_on, :notes, :severity)
    end
end
