class InPatientsController < ApplicationController
  before_action :set_in_patient, only: [:show, :edit, :update, :destroy]

  # GET /in_patients
  # GET /in_patients.json
  def index
    @in_patients = InPatient.all
  end

  # GET /in_patients/1
  # GET /in_patients/1.json
  def show
  end

  # GET /in_patients/new
  def new
    @in_patient = InPatient.new
  end

  # GET /in_patients/1/edit
  def edit
  end

  # POST /in_patients
  # POST /in_patients.json
  def create
    @in_patient = InPatient.new(in_patient_params)

    respond_to do |format|
      if @in_patient.save
        format.html { redirect_to @in_patient, notice: 'In patient was successfully created.' }
        format.json { render :show, status: :created, location: @in_patient }
      else
        format.html { render :new }
        format.json { render json: @in_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /in_patients/1
  # PATCH/PUT /in_patients/1.json
  def update
    respond_to do |format|
      if @in_patient.update(in_patient_params)
        format.html { redirect_to @in_patient, notice: 'In patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @in_patient }
      else
        format.html { render :edit }
        format.json { render json: @in_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_patients/1
  # DELETE /in_patients/1.json
  def destroy
    @in_patient.destroy
    respond_to do |format|
      format.html { redirect_to in_patients_url, notice: 'In patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_in_patient
      @in_patient = InPatient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def in_patient_params
      params.require(:in_patient).permit(:user_id, :doctor_id, :visting_since, :notes, :status, :for_practice)
    end
end
