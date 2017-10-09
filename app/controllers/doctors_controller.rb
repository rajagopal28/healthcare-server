class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  # GET /doctors
  # GET /doctors.json
  def index
    first_name = request.query_parameters['firstName']
    last_name = request.query_parameters['lastName']
    if first_name && last_name
      @doctors = Doctor.where(first_name: first_name.to_s.capitalize, last_name: last_name.to_s.capitalize)
    else
      @doctors = Doctor.all
    end

  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # GET /doctors/login
  def login
    @doctor = Doctor.new
  end

  # GET /doctors/logout
  def logout
    session.delete(:doctor_id)
     redirect_to :controller => 'home', :action => 'index'
  end

  # POST /doctors/singin
  # POST /doctors/signin.json
  def signin
    @doctor = Doctor.new(login_params)
    _doctor = Doctor.where(username: login_params[:username], password: login_params[:password]).first()
    if login_params[:gcmid]
      _doctor.update_column(:gcmid, login_params[:gcmid])
    end
    respond_to do |format|
      if _doctor
        @doctor = _doctor
        session[:doctor_id] = @doctor.id
        format.html { redirect_to :controller => 'home', :action => 'index'  }
        format.json { render :show, status: :created, location: @doctor }
      else
        @doctor.errors.add(:username, :blank, message: "Invalid credentials")
        format.html { render :login }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /doctors
  # POST /doctors.json
  def create
    @doctor = Doctor.new(doctor_params)

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'Doctor was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:first_name, :last_name, :city, :username, :password, :address, :primary_practice, :secondary_practice, :gcmid)
    end

    def login_params
      params.require(:doctor).permit(:username, :password, :gcmid)
    end
end
