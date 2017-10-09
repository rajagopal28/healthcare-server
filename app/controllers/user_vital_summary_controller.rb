class UserVitalSummaryController < ApplicationController
  before_action :set_user_from_session, only: [:index]

  def index
      if @user
        logs = UserVitalLog.where(user_id: @user.id).group(:user_id).select([:user_id, "AVG(pressure) as pressure", "AVG(sugar) as sugar", "AVG(temperature) as temperature", "AVG(pulse) as pulse"])
      else
        logs = UserVitalLog.group(:user_id).select([:user_id, "AVG(pressure) as pressure", "AVG(sugar) as sugar", "AVG(temperature) as temperature", "AVG(pulse) as pulse"])
      end
      @user_vital_summary = logs.map{|uv| UserVitalSummary.new(user_vital_log: uv, pressure_status: get_pressure_status(uv.pressure), sugar_status: get_sugar_status(uv.sugar), pulse_status: get_pulse_status(uv.pulse), temperature_status: get_temperature_status(uv.temperature)) }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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

end
