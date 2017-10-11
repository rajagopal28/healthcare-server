class UserVitalLogsController < ApplicationController
  before_action :set_user_vital_log, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit]
  before_action :set_user_from_session, only: [:index, :new]

  # GET /user_vital_logs
  # GET /user_vital_logs.json
  def index
    if @user
      @user_vital_logs = UserVitalLog.where(user_id: @user.id)
    else
      @user_vital_logs = UserVitalLog.all
    end
  end

  # GET /user_vital_logs/1
  # GET /user_vital_logs/1.json
  def show
  end

  # GET /user_vital_logs/new
  def new
    @user_vital_log = UserVitalLog.new
  end

  # GET /user_vital_logs/1/edit
  def edit
  end

  # POST /user_vital_logs
  # POST /user_vital_logs.json
  def create
    @user_vital_log = UserVitalLog.new(user_vital_log_params)

    respond_to do |format|
      if @user_vital_log.save
        check_vital_violation_and_send_notifications
        format.html { redirect_to @user_vital_log, notice: 'User vital log was successfully created.' }
        format.json { render :show, status: :created, location: @user_vital_log }
      else
        format.html { render :new }
        format.json { render json: @user_vital_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_vital_logs/1
  # PATCH/PUT /user_vital_logs/1.json
  def update
    respond_to do |format|
      if @user_vital_log.update(user_vital_log_params)
        format.html { redirect_to @user_vital_log, notice: 'User vital log was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_vital_log }
      else
        format.html { render :edit }
        format.json { render json: @user_vital_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_vital_logs/1
  # DELETE /user_vital_logs/1.json
  def destroy
    @user_vital_log.destroy
    respond_to do |format|
      format.html { redirect_to user_vital_logs_url, notice: 'User vital log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_vital_log
      @user_vital_log = UserVitalLog.find(params[:id])
    end

    def set_users
      @users = User.all
    end

    def set_user_from_session
      #initialise ids
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
    end

    def check_vital_violation_and_send_notifications
      if @user_vital_log
        pressure_status = get_pulse_status(@user_vital_log.pressure)
        sugar_status = get_pulse_status(@user_vital_log.sugar)
        temperature_status = get_pulse_status(@user_vital_log.temperature)
        pulse_status = get_pulse_status(@user_vital_log.pulse)

        notes = ''
        if pressure_status != 'Normal'
          notes = notes + "Pressure #{pressure_status} (#{@user_vital_log.pressure})"
        end
        if sugar_status != 'Normal'
          notes = notes + " Sugar  #{sugar_status } (#{@user_vital_log.sugar})"
        end
        if temperature_status != 'Normal'
          notes = notes + " Temperature  #{ temperature_status } (#{ @user_vital_log.temperature})"
        end
        if pulse_status != 'Normal'
          notes = notes + " Pulse  #{ pulse_status } (#{@user_vital_log.pulse})"
        end
        find_all_doctors_related_and_create_notification(notes)
      end
    end

    def find_all_doctors_related_and_create_notification(notes)
      # find all doctors in this user's inpatient
      in_patients = InPatient.where(user_id: @user_vital_log.user.id)
      in_patients.each do |ip|
        #create doctor notification for each doctor
        doctor_notification = DoctorNotification.new(doctor_id: ip.doctor.id, user_id: ip.user.id, title: 'Vital critical!', notes: notes, severity: 'High', notified_on: DateTime.now)
        if doctor_notification.save
          send_notification_to_doctors_on_vital_violation(doctor_notification)
          puts "Notification(#{doctor_notification.title}) of Patient: #{doctor_notification.user.first_name} Severity: #{doctor_notification.severity}"
        end
      end
    end

    def send_notification_to_doctors_on_vital_violation( _doctor_notification)
      #send notification for valid selenium-webdriver
      _doctor = _doctor_notification.doctor
      if _doctor.gcmid && _doctor.gcmid.length > 10
        url = 'https://gcm-http.googleapis.com/gcm/send'
        title = "Notification(#{_doctor_notification.title}) of Patient: #{_doctor_notification.user.first_name} Severity: #{_doctor_notification.severity}"
        payload = { notification: {
              title: title,
              text: _doctor_notification.notes
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

    # status check logic to be moved out to common
    def get_pressure_status(value)
      return value < 50 ? 'Low' : ( value < 100? 'Normal' : 'High')
    end


    def get_sugar_status(value)
      return value < 50 ? 'Low' : ( value < 100? 'Normal' : 'High')
    end


    def get_temperature_status(value)
      return value < 50 ? 'Low' : ( value < 100? 'Normal' : 'High')
    end


    def get_pulse_status(value)
      return value < 50 ? 'Low' : ( value < 100? 'Normal' : 'High')
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_vital_log_params
      params.require(:user_vital_log).permit(:user_id, :logged_on, :notes, :pressure, :sugar, :temperature, :pulse)
    end
end
