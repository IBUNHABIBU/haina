# app/controllers/tv_panels_controller.rb
class TvPanelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tv_panel, only: %i[show edit update destroy]

  def index
    @tv_panels = TvPanel.includes(:tv_brand, :tv_size, :customer).order(created_at: :desc)
    @in_stock_count = @tv_panels.count { |p| p.in_stock? }
    @sold_count = @tv_panels.count { |p| p.sold? }
    @total_profit = @tv_panels.select(&:sold?).sum(&:profit)
  end

  def show; end
  def new
    @tv_panel = TvPanel.new
    load_form_options
  end
  def edit
    load_form_options
  end

  def create
    @tv_panel = TvPanel.new(tv_panel_params)
    if @tv_panel.save
      redirect_to tv_panels_path, notice: "Bango limesajiliwa."
    else
      load_form_options
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tv_panel.update(tv_panel_params)
      # Kama ameuza, weka tarehe ya kuuza automatically
      if @tv_panel.saved_change_to_status? && @tv_panel.sold?
        @tv_panel.update_column(:sold_at, Time.current)
      end
      redirect_to tv_panels_path, notice: "Bango limeupdate."
    else
      load_form_options
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tv_panel.destroy!
    redirect_to tv_panels_path, notice: "Bango limefutwa."
  end

  private

  def set_tv_panel
    @tv_panel = TvPanel.find(params[:id])
  end

  def load_form_options
    @tv_brands = TvBrand.order(:name)
    @tv_sizes = TvSize.order(:size)
    @customers = Customer.order(:name)
  end

  def tv_panel_params
    params.require(:tv_panel).permit(:tv_brand_id, :tv_size_id,
     :customer_id, :buy_price, :sell_price, :status,
      :remarks, :front_image, :back_image # <-- Ongeza hizi
     )
  end
end