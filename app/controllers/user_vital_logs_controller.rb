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
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_vital_log_params
      params.require(:user_vital_log).permit(:user_id, :logged_on, :notes, :pressure, :sugar, :temperature, :pulse)
    end
end
