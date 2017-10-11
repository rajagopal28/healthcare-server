class DoctorNotificationsController < ApplicationController
  before_action :set_doctor_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_doctors_and_users, only: [:new, :edit]
  before_action :set_doctor_user_from_session, only: [:index, :new]

  # GET /doctor_notifications
  # GET /doctor_notifications.json
  def index
    if @doctor && @user
      @doctor_notifications = DoctorNotification.where(doctor_id: @doctor.id, user_id: @user.id)
    elsif @user
      @doctor_notifications = DoctorNotification.where(user_id: @user.id)
    elsif @doctor
      @doctor_notifications = DoctorNotification.where(doctor_id: @doctor.id)
    else
      @doctor_notifications = DoctorNotification.all
    end
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
        send_notification_for_doctor_device
        # send response
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

    def send_notification_for_doctor_device
      #send notification for valid selenium-webdriver
      _doctor = @doctor_notification.doctor
      if _doctor.gcmid && _doctor.gcmid.length > 10
        url = 'https://gcm-http.googleapis.com/gcm/send'
        title = "Notification(#{@doctor_notification.title}) of Patient: #{@doctor_notification.user.first_name} Severity: #{@doctor_notification.severity}"
        payload = { notification: {
              title: title,
              text: @doctor_notification.notes
            },
            to: _doctor.gcmid
          }
          # puts JSON.generate(payload)
          # puts "key="+Rails.application.secrets.gcm_server_auth_key
          # puts JSON.generate({"Content-Type" => "application/json", :Authorization => "key="+Rails.application.secrets.gcm_server_auth_key})
          resp = RestClient::Request.execute(
                 :method => :post,
                 :url => url,
                 :payload => JSON.generate(payload),
                 :headers => {"Content-Type" => "application/json", "Authorization" => "key="+Rails.application.secrets.gcm_server_auth_key}
                    )
          puts resp
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_notification_params
      params.require(:doctor_notification).permit(:title, :user_id, :doctor_id, :notified_on, :notes, :severity)
    end
end
