class SpareCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spare_category, only: %i[edit update destroy]

  def index
    @spare_categories = SpareCategory.order(:name)
    @spare_category = SpareCategory.new
  end

  def create
    @spare_category = SpareCategory.new(spare_category_params)
    if @spare_category.save
      redirect_to spare_categories_path, notice: "Spare category was created."
    else
      @spare_categories = SpareCategory.order(:name)
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @spare_category.update(spare_category_params)
      redirect_to spare_categories_path, notice: "Spare category was updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spare_category.destroy!
    redirect_to spare_categories_path, notice: "Spare category was deleted.", status: :see_other
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to spare_categories_path, alert: "This category contains spares and cannot be deleted."
  end

  private

  def set_spare_category
    @spare_category = SpareCategory.find(params[:id])
  end

  def spare_category_params
    params.require(:spare_category).permit(:name, :code, :description)
  end
end
