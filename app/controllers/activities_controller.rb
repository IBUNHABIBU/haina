class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show edit update destroy]
  before_action :load_form_options, only: %i[new edit create update]

  def index
    @activities = Activity.includes(:customer, :tv_brand, :tv_size, :tatizo).order(date_in: :desc, created_at: :desc)
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
    end

    redirect_to @activity, notice: "Repair activity was successfully updated.", status: :see_other
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
    @tv_sizes = TvSize.order(:size)
    @tatizos = Tatizo.order(:name)
    @spares = Spare.includes(:spare_category).order(:name)
  end

  def activity_params
    params.require(:activity).permit(
      :customer_id, :tv_brand_id, :tv_size_id, :tatizo_id, :phone, :model_no,
      :date_in, :date_out, :price, :labour_charge, :status, :remarks,
      :pattern_image, :model_image, :board_number, :tcon_number, :cof_number,
      :panel_number, :image_before, :image_after
    )
  end

  def replace_spares!
    @activity.activity_spares.destroy_all

    spare_ids = Array(params[:spare_ids]).reject(&:blank?)
    quantities = Array(params[:spare_quantities])

    spare_ids.each_with_index do |spare_id, index|
      quantity = quantities[index].to_i
      next if quantity <= 0

      @activity.activity_spares.create!(spare_id: spare_id, quantity: quantity)
    end
  end
end
