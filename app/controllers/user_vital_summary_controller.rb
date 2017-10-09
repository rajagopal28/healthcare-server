class UserVitalSummaryController < ApplicationController
  before_action :set_user_from_session, only: [:index]

  def index
      if @user
        logs = UserVitalLog.where(user_id: @user.id).group(:user_id).select([:user_id, "AVG(pressure) as pressure", "AVG(sugar) as sugar", "AVG(temperature) as temperature", "AVG(pulse) as pulse"])
      else
        logs = UserVitalLog.group(:user_id).select([:user_id, "AVG(pressure) as pressure", "AVG(sugar) as sugar", "AVG(temperature) as temperature", "AVG(pulse) as pulse"])
      end
      @user_vital_summary = logs.map{|uv| UserVitalSummary.new(user_vital_log: uv, pressure_status: 'Normal', sugar_status: 'Normal', temperature_status: 'Normal', pulse_status: 'Normal') }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
