class MedicineIntakeLogsController < ApplicationController
  before_action :set_medicine_intake_log, only: [:show, :edit, :update, :destroy]
  before_action :set_users_and_meds, only: [:new, :edit]
  before_action :set_user_from_session, only: [:index, :new]

  # GET /medicine_intake_logs
  # GET /medicine_intake_logs.json
  def index
    if @user
      @medicine_intake_logs = MedicineIntakeLog.where(user_id: @user.id)
    else
      @medicine_intake_logs = MedicineIntakeLog.all
    end
  end

  # GET /medicine_intake_logs/1
  # GET /medicine_intake_logs/1.json
  def show
  end

  # GET /medicine_intake_logs/new
  def new
    @medicine_intake_log = MedicineIntakeLog.new
  end

  # GET /medicine_intake_logs/1/edit
  def edit
  end

  # POST /medicine_intake_logs
  # POST /medicine_intake_logs.json
  def create
    @medicine_intake_log = MedicineIntakeLog.new(medicine_intake_log_params)

    respond_to do |format|
      if @medicine_intake_log.save
        format.html { redirect_to @medicine_intake_log, notice: 'Medicine intake log was successfully created.' }
        format.json { render :show, status: :created, location: @medicine_intake_log }
      else
        format.html { render :new }
        format.json { render json: @medicine_intake_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicine_intake_logs/1
  # PATCH/PUT /medicine_intake_logs/1.json
  def update
    respond_to do |format|
      if @medicine_intake_log.update(medicine_intake_log_params)
        format.html { redirect_to @medicine_intake_log, notice: 'Medicine intake log was successfully updated.' }
        format.json { render :show, status: :ok, location: @medicine_intake_log }
      else
        format.html { render :edit }
        format.json { render json: @medicine_intake_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicine_intake_logs/1
  # DELETE /medicine_intake_logs/1.json
  def destroy
    @medicine_intake_log.destroy
    respond_to do |format|
      format.html { redirect_to medicine_intake_logs_url, notice: 'Medicine intake log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine_intake_log
      @medicine_intake_log = MedicineIntakeLog.find(params[:id])
    end

    def set_users_and_meds
      @users = User.all
      @prescribed_medicines = PrescribedMedicine.all
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
    def medicine_intake_log_params
      params.require(:medicine_intake_log).permit(:prescribed_medicine_id, :user_id, :logged_on, :notes, :part_of_day)
    end
end
