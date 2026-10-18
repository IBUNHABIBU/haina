class SpareRequestsController < ApplicationController
  before_action :set_spare_request, only: %i[ show edit update destroy ]

  # GET /spare_requests or /spare_requests.json
  def index
      @spare_requests = SpareRequest.includes(
    :activity, :spare, :requested_by
  ).order(created_at: :desc)
  end

  # GET /spare_requests/1 or /spare_requests/1.json
  def show
  end

  # GET /spare_requests/new
  def new
      @activity = Activity.find(params[:activity_id]) if params[:activity_id]

  @spare_request = SpareRequest.new(
    activity: @activity,
    request_type: @activity ? :activity : nil,
    requested_quantity: 1,
    issued_quantity: 0,
    status: :requested
  )
  end

  # GET /spare_requests/1/edit
  def edit
  end

  # POST /spare_requests or /spare_requests.json
  def create
      @activity = Activity.find(params[:activity_id]) if params[:activity_id]

      @spare_request = SpareRequest.new(spare_request_params)
      @spare_request.activity = @activity if @activity
      @spare_request.requested_by = current_user
      @spare_request.issued_quantity = 0
      @spare_request.status = :requested

      if @activity
        @spare_request.request_type = :activity
      end

      if @spare_request.save
        redirect_to(
          @activity || spare_requests_path,
          notice: "Spare request was successfully created."
        )
      else
        render :new, status: :unprocessable_entity
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
        params.expect(
        spare_request: [
          :request_type,
          :activity_id,
          :spare_id,
          :requested_quantity,
          :reason
        ]
      )
    end
end
