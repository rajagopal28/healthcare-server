require 'time'
class PrescribedMedicinesController < ApplicationController
  before_action :set_prescribed_medicine, only: [:show, :edit, :update, :destroy]
  before_action :set_medicines_and_prescriptions, only: [:new, :edit]
  before_action :set_prescription_medicines_from_param, only: [:index, :new, :filtered]

  # GET /prescribed_medicines
  # GET /prescribed_medicines.json
  def index
    load_data_based_on_session
  end


  # GET /prescribed_medicines/filtered
  # GET /prescribed_medicines/filtered.json
  def filtered
    load_data_based_on_session
    part_of_day = get_part_of_day
    if part_of_day
      case part_of_day
      when "morning"
        start = DateTime.now.change({ hour: 6, min: 0, sec: 0 })
        finish = DateTime.now.change({ hour: 11, min: 0, sec: 0 })
      when "noon"
        start = DateTime.now.change({ hour: 12, min: 0, sec: 0 })
        finish = DateTime.now.change({ hour: 17, min: 0, sec: 0 })
      when "night"
        start = DateTime.now.change({ hour: 18, min: 0, sec: 0 })
        finish = DateTime.now.change({ hour: 22, min: 0, sec: 0 })
      end
      _medicine_intake_logs = MedicineIntakeLog.where(:logged_on => start..finish)
      _prescribed_medicines_ids = _medicine_intake_logs.map{|pm| pm.id}
      if !@prescribed_medicines.empty?
          @prescribed_medicines = @prescribed_medicines.where.not(id: _prescribed_medicines_ids)
      end
    end
  end


  # GET /prescribed_medicines/1
  # GET /prescribed_medicines/1.json
  def show
  end

  # GET /prescribed_medicines/new
  def new
    @prescribed_medicine = PrescribedMedicine.new
  end

  # GET /prescribed_medicines/1/edit
  def edit
  end

  # POST /prescribed_medicines
  # POST /prescribed_medicines.json
  def create
    @prescribed_medicine = PrescribedMedicine.new(prescribed_medicine_params)

    respond_to do |format|
      if @prescribed_medicine.save
        format.html { redirect_to @prescribed_medicine, notice: 'Prescribed medicine was successfully created.' }
        format.json { render :show, status: :created, location: @prescribed_medicine }
      else
        format.html { render :new }
        format.json { render json: @prescribed_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prescribed_medicines/1
  # PATCH/PUT /prescribed_medicines/1.json
  def update
    respond_to do |format|
      if @prescribed_medicine.update(prescribed_medicine_params)
        format.html { redirect_to @prescribed_medicine, notice: 'Prescribed medicine was successfully updated.' }
        format.json { render :show, status: :ok, location: @prescribed_medicine }
      else
        format.html { render :edit }
        format.json { render json: @prescribed_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescribed_medicines/1
  # DELETE /prescribed_medicines/1.json
  def destroy
    @prescribed_medicine.destroy
    respond_to do |format|
      format.html { redirect_to prescribed_medicines_url, notice: 'Prescribed medicine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescribed_medicine
      @prescribed_medicine = PrescribedMedicine.find(params[:id])
    end

    def set_medicines_and_prescriptions
      @medicines = Medicine.all
      @prescriptions = Prescription.all
    end

    def set_prescription_medicines_from_param
      _medicine_id = request.query_parameters['medicineId']
      _prescription_id = request.query_parameters['prescriptionId']
      time_param = request.query_parameters['time']
      _user_id = session[:user_id] ? session[:user_id] : request.query_parameters['userId']

      if _medicine_id
        @medicine = Medicine.find(medicine_id)
      end
      if _prescription_id
        @prescription = Prescription.find(_prescription_id)
      end

      if _user_id
        @user = User.find(_user_id)
      end

      if time_param == 'now'
        @part_of_day = get_part_of_day
      end
    end

    def get_part_of_day
      _hour = Time.now.hour
      part_of_day = 'morning'
      if _hour > 5 && _hour < 12
        part_of_day = 'morning'
      elsif _hour >=12 && _hour < 18
        part_of_day = 'noon'
      elsif _hour >=18 && _hour < 22
        part_of_day = 'night'
      end
      puts part_of_day
      return part_of_day
    end

    def load_data_based_on_session
      if @user
          _prescription_ids = @user.prescriptions.map{|pr| pr.id}
          @prescribed_medicines = PrescribedMedicine.where(prescription_id: _prescription_ids)
          if @part_of_day
            case @part_of_day
            when "morning"
              condition = 'before_breakfast=? OR after_breakfast=?'
            when "noon"
              condition = 'before_lunch=? OR after_lunch=?'
            when "night"
              condition = 'before_lunch=? OR after_lunch=?'
            end
            @prescribed_medicines = @prescribed_medicines.where(condition, 't', 't')
         end
      else
        if @prescription && @medicine
          @prescribed_medicines = PrescribedMedicine.where(prescription_id: @prescription.id, medicine_id: @medicine.id)
        elsif @prescription
          @prescribed_medicines = PrescribedMedicine.where(prescription_id: @prescription.id)
        elsif @medicine
          @prescribed_medicines = PrescribedMedicine.where(medicine_id: @medicine.id)
        else
          if @part_of_day
            case @part_of_day
            when "morning"
              condition = 'before_breakfast=? OR after_breakfast=?'
            when "noon"
              condition = 'before_lunch=? OR after_lunch=?'
            when "night"
                condition = 'before_lunch=? OR after_lunch=?'
            end
            @prescribed_medicines = @prescribed_medicines.where(condition, 't', 't')
          else
            @prescribed_medicines = PrescribedMedicine.all
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescribed_medicine_params
      params.require(:prescribed_medicine).permit(:medicine_id, :prescription_id, :notes, :before_breakfast, :after_breakfast, :before_lunch, :after_lunch, :before_dinner, :after_dinner, :available_count)
    end
end
