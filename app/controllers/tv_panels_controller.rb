class TvPanelsController < ApplicationController
  before_action :set_tv_panel, only: %i[ show edit update destroy ]

  # GET /tv_panels or /tv_panels.json
  def index
    @tv_panels = TvPanel.all
  end

  # GET /tv_panels/1 or /tv_panels/1.json
  def show
  end

  # GET /tv_panels/new
  def new
    @tv_panel = TvPanel.new
  end

  # GET /tv_panels/1/edit
  def edit
  end

  # POST /tv_panels or /tv_panels.json
  def create
    @tv_panel = TvPanel.new(tv_panel_params)

    respond_to do |format|
      if @tv_panel.save
        format.html { redirect_to @tv_panel, notice: "Tv panel was successfully created." }
        format.json { render :show, status: :created, location: @tv_panel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tv_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tv_panels/1 or /tv_panels/1.json
  def update
    respond_to do |format|
      if @tv_panel.update(tv_panel_params)
        format.html { redirect_to @tv_panel, notice: "Tv panel was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tv_panel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tv_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tv_panels/1 or /tv_panels/1.json
  def destroy
    @tv_panel.destroy!

    respond_to do |format|
      format.html { redirect_to tv_panels_path, notice: "Tv panel was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tv_panel
      @tv_panel = TvPanel.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tv_panel_params
      params.expect(tv_panel: [ :tv_brand_id, :tv_size_id, :customer_id, :buy_price, :sell_price, :status, :sold_at ])
    end
end
