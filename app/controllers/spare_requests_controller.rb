class SpareRequestsController < ApplicationController
  before_action :set_spare_request, only: %i[ show edit update destroy ]

  # GET /spare_requests or /spare_requests.json
  def index
    @spare_requests = SpareRequest.all
  end

  # GET /spare_requests/1 or /spare_requests/1.json
  def show
  end

  # GET /spare_requests/new
  def new
    @spare_request = SpareRequest.new
  end

  # GET /spare_requests/1/edit
  def edit
  end

  # POST /spare_requests or /spare_requests.json
  def create
    @spare_request = SpareRequest.new(spare_request_params)

    respond_to do |format|
      if @spare_request.save
        format.html { redirect_to @spare_request, notice: "Spare request was successfully created." }
        format.json { render :show, status: :created, location: @spare_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spare_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spare_requests/1 or /spare_requests/1.json
  def update
    respond_to do |format|
      if @spare_request.update(spare_request_params)
        format.html { redirect_to @spare_request, notice: "Spare request was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @spare_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spare_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spare_requests/1 or /spare_requests/1.json
  def destroy
    @spare_request.destroy!

    respond_to do |format|
      format.html { redirect_to spare_requests_path, notice: "Spare request was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spare_request
      @spare_request = SpareRequest.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def spare_request_params
      params.expect(spare_request: [ :activity_id, :spare_id, :requested_by_id, :issued_by_id, :requested_quantity, :issued_quantity, :unit_cost_at_issue, :status, :reason, :store_notes, :issued_at ])
    end
end
