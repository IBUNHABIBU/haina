class SpareRequestsController < ApplicationController
  before_action :set_spare_request, only: %i[ show edit update destroy ]

  # GET /spare_requests or /spare_requests.json
  def index
      @spare_requests = SpareRequest.includes(
    :activity, :spare, :requested_by
  ).order(created_at: :desc)

      respond_to do |format|
        format.html
        format.xlsx do
          response.headers['Content-Disposition'] = "attachment; filename=spare_requests_#{Time.current.strftime('%Y-%m-%d')}.xlsx"
        end
      end
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

    
def generate_csv(requests)
  CSV.generate(headers: true) do |csv|
    # Ongeza vichwa vya safu (Headers)
    csv << [
      "Request ID", "Date", "Type", "Spare Name", "Part Number", 
      "Qty Requested", "Linked Activity", "Customer", "TV Brand", 
      "TV Size", "Requested By", "Status"
    ]

    # Weka data ya kila request
    requests.each do |request|
      csv << [
        "##{request.id}",
        request.created_at&.strftime("%Y-%m-%d %H:%M"),
        request.request_type&.humanize,
        request.spare&.name || "Spare unavailable",
        request.spare&.part_number || "—",
        request.requested_quantity,
        request.activity ? "##{request.activity.id}" : "—",
        request.activity&.customer&.name || "—",
        request.activity&.tv_brand&.name || "—",
        request.activity&.tv_size&.size || "—",
        [request.requested_by&.first_name, request.requested_by&.last_name].compact.join(" ").presence || "—",
        request.status&.humanize
      ]
    end
  end

end 
end 