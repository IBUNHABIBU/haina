class SparesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spare, only: %i[show edit update destroy]

  def index
    @spares = Spare.includes(:spare_category).order(:name)
    @low_stock_count = Spare.low_stock.count
  end

  def show
  end

  def new
    @spare = Spare.new
    @categories = SpareCategory.order(:name)
  end

  def edit
    @categories = SpareCategory.order(:name)
  end

  def create
    @spare = Spare.new(spare_params)
    if @spare.save
      redirect_to spares_path, notice: "Spare was successfully created."
    else
      @categories = SpareCategory.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @spare.update(spare_params)
      redirect_to @spare, notice: "Spare was successfully updated.", status: :see_other
    else
      @categories = SpareCategory.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spare.destroy!
    redirect_to spares_path, notice: "Spare was deleted.", status: :see_other
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to spares_path, alert: "This spare is already used in records and cannot be deleted."
  end

  private

  def set_spare
    @spare = Spare.find(params[:id])
  end

  def spare_params
    params.require(:spare).permit(:spare_category_id, :name, :part_number, :brand, :unit_cost, :selling_price, :quantity, :reorder_level, :location, :notes)
  end
end
