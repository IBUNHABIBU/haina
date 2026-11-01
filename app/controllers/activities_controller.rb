class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show edit update destroy]
  before_action :load_form_options, only: %i[new edit create update]

def index
  scope = Activity
    .includes(:customer, :tv_brand, :tv_size, :tatizo)
    .search(params[:q])
    .order(date_in: :desc, created_at: :desc)

  @activities = scope

  @total_count     = Activity.count
  @in_progress     = Activity.where(status: %w[received in_progress]).count
  @completed_today = Activity.where(status: "completed", updated_at: Time.current.all_day).count
  @total_revenue   = Activity.sum(:price)

  respond_to do |format|
  format.html

  format.turbo_stream do
    if params[:q].present?
      render turbo_stream: turbo_stream.replace(
        "activities",
        partial: "activities/list",
        locals: {
          activities: @activities,
          query: params[:q]
        }
      )
    else
      render :index, formats: [:html]
    end
  end
end
end

  def show
  end

  def new
    @activity = Activity.new(date_in: Time.current, status: :received)
  end

  def edit
  end

  def create
      @activity = current_user.activities.build(activity_params)

      Activity.transaction do
        @activity.save!
        replace_spares!
        @activity.recalculate_gross_profit!
      end

      redirect_to @activity, notice: "Repair activity was successfully created."
      rescue ActiveRecord::RecordInvalid
        load_form_options
        render :new, status: :unprocessable_entity
  end

  def update
      Activity.transaction do
        @activity.update!(activity_params)
        replace_spares!
        @activity.recalculate_gross_profit!
      end

      redirect_to @activity,
                  notice: "Repair activity was successfully updated.",
                  status: :see_other
    rescue ActiveRecord::RecordInvalid
      load_form_options
      render :edit, status: :unprocessable_entity
  end

def destroy
  @activity.destroy!
  redirect_to activities_path, notice: "Repair activity was successfully deleted.", status: :see_other
end

  private

  def set_activity
    @activity = Activity.includes(:activity_spares, :repair_returns).find(params[:id])
  end

  def load_form_options
    @customers = Customer.order(:name)
    @tv_brands = TvBrand.order(:name)
    @tv_sizes  = TvSize.order(:size)
    @tatizos   = Tatizo.order(:name)
    @spares    = Spare.includes(:spare_category).order(:name)
  end

  def activity_params
    params.require(:activity).permit(
      :customer_id, :tv_brand_id, :tv_size_id, :tatizo_id, :phone, :model_no,
      :date_in, :date_out, :price, :labour_charge, :status, :remarks,
      :pattern_image, :model_image, :board_number, :tcon_number, :cof_number,
      :panel_number, :image_before, :image_after, :model_image, :board_image,
      :tcon_image, :cof_image, :panel_image, :starting_price, :number_of_cof
    )
  end

  def replace_spares!
    spare_ids = Array(params[:spare_ids])
    quantities = Array(params[:spare_quantities])

    requested = Hash.new(0)

    spare_ids.each_with_index do |spare_id, index|
      next if spare_id.blank?

      quantity = quantities[index].to_i
      next if quantity <= 0

      requested[spare_id.to_i] += quantity
    end

    existing = @activity.activity_spares.to_a

    # Remove spares ambazo hazipo tena kwenye form
    existing.each do |item|
      unless requested.key?(item.spare_id)
        item.destroy!
      end
    end

    # Add new spares or update quantities
    requested.each do |spare_id, quantity|
      item = existing.find { |record| record.spare_id == spare_id }

      if item.nil?
        @activity.activity_spares.create!(
          spare_id: spare_id,
          quantity: quantity
        )
      elsif item.quantity != quantity
        item.update!(quantity: quantity)
      end
    end

    @activity.recalculate_gross_profit!
  end
end