class RepairJobsController < ApplicationController
  before_action :set_repair_job, only: %i[ show edit update destroy ]

  # GET /repair_jobs or /repair_jobs.json
  def index
    @repair_jobs = RepairJob.all
  end

  # GET /repair_jobs/1 or /repair_jobs/1.json
  def show
  end

  # GET /repair_jobs/new
  def new
    @repair_job = RepairJob.new
  end

  # GET /repair_jobs/1/edit
  def edit
  end

  # POST /repair_jobs or /repair_jobs.json
  def create
    @repair_job = RepairJob.new(repair_job_params)

    respond_to do |format|
      if @repair_job.save
        format.html { redirect_to @repair_job, notice: "Repair job was successfully created." }
        format.json { render :show, status: :created, location: @repair_job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repair_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repair_jobs/1 or /repair_jobs/1.json
  def update
    respond_to do |format|
      if @repair_job.update(repair_job_params)
        format.html { redirect_to @repair_job, notice: "Repair job was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @repair_job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repair_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_jobs/1 or /repair_jobs/1.json
  def destroy
    @repair_job.destroy!

    respond_to do |format|
      format.html { redirect_to repair_jobs_path, notice: "Repair job was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair_job
      @repair_job = RepairJob.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def repair_job_params
      params.expect(repair_job: [ :customer_id, :tv_brand_id, :tv_size_id, :labour_price, :total_sale, :status, :tatizo, :reference, :motherboard_number, :tcon_number, :panel_number, :cof_number ])
    end
end
