class SpareRequestsController < ApplicationController
  before_action :set_spare_request, only: %i[show edit update destroy]

 # app/controllers/spare_requests_controller.rb
def index
  scope = SpareRequest.includes(:activity, :spare, :requested_by).order(created_at: :desc)

  # Filter by status
  if params[:status].present?
    scope = scope.where(status: params[:status])
  end

  @spare_requests = scope

  # KPI (zinahesabiwa kutoka kwenye scope ili zibadilike pamoja na filter)
  @total_requests = scope.count
  @activity_count = scope.where(request_type: :activity).count
  @workshop_count = scope.where(request_type: :workshop).count
  @stock_count    = scope.where(request_type: :stock_replenishment).count

  respond_to do |format|
    format.html
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(
        "spare_requests_list",
        partial: "spare_requests/list",
        locals: { spare_requests: @spare_requests }
      )
    end
  end
end

  def show
  end

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

  def edit
  end

  def create
    @activity = Activity.find(params[:activity_id]) if params[:activity_id].present?

    @spare_request = SpareRequest.new(spare_request_params)

    if @activity
      @spare_request.activity = @activity
      @spare_request.request_type = :activity
      @spare_request.spare_id = nil
    end

    @spare_request.requested_by = current_user
    @spare_request.issued_quantity = 0
    @spare_request.status = :requested

    if @spare_request.valid?
      SpareRequest.transaction do
        @spare_request.save!
        @activity.update!(status: :spare_requested) if @activity
      end

      redirect_to(
        @activity || spare_requests_path,
        notice: "Spare request was successfully created."
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @spare_request.update(spare_request_params)
        format.html { redirect_to @spare_request, notice: "Spare request was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @spare_request }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@spare_request),
            partial: "spare_requests/spare_request_row",
            locals: { request: @spare_request }
          )
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spare_request.errors, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@spare_request),
            partial: "spare_requests/spare_request_row",
            locals: { request: @spare_request }
          )
        end
      end
    end
  end

  def destroy
    @spare_request.destroy!

    respond_to do |format|
      format.html { redirect_to spare_requests_path, alert: "Spare request was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_spare_request
    @spare_request = SpareRequest.find(params[:id])
  end

  def spare_request_params
    params.require(:spare_request).permit(
      :request_type,
      :activity_id,
      :spare_id,
      :spare_type,
      :requested_quantity,
      :reason,
      :status
    )
  end

  def generate_csv(requests)
    CSV.generate(headers: true) do |csv|
      csv << [
        "Request ID", "Date", "Type", "Spare Name", "Part Number",
        "Qty Requested", "Linked Activity", "Customer", "TV Brand",
        "TV Size", "Requested By", "Status"
      ]

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