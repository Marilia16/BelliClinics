class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[ show edit update destroy ]

  # GET /clinics
  def index
    @clinics = current_user.clinics
  end

  # GET /clinics/1
  def show
  end

  # GET /clinics/new
  def new
    @clinic = current_user.clinics.new
  end

  # GET /clinics/1/edit
  def edit
  end

  # POST /clinics
  def create
    @clinic = current_user.clinics.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @clinic, notice: "Clinic was successfully created." }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1
  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to @clinic, notice: "Clinic was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1
  def destroy
    @clinic.destroy!

    respond_to do |format|
      format.html { redirect_to clinics_path, notice: "Clinic was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = current_user.clinics.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def clinic_params
      params.expect(clinic: [ :name, :cnpj ])
    end
end
