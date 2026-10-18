class AllPricesController < ApplicationController
  before_action :set_all_price, only: %i[ show edit update destroy ]

  # GET /all_prices or /all_prices.json
  def index
    @all_prices = AllPrice.all
  end

  # GET /all_prices/1 or /all_prices/1.json
  def show
  end

  # GET /all_prices/new
  def new
    @all_price = AllPrice.new
  end

  # GET /all_prices/1/edit
  def edit
  end

  # POST /all_prices or /all_prices.json
  def create
    @all_price = AllPrice.new(all_price_params)

    respond_to do |format|
      if @all_price.save
        format.html { redirect_to @all_price, notice: "All price was successfully created." }
        format.json { render :show, status: :created, location: @all_price }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @all_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /all_prices/1 or /all_prices/1.json
  def update
    respond_to do |format|
      if @all_price.update(all_price_params)
        format.html { redirect_to @all_price, notice: "All price was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @all_price }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @all_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /all_prices/1 or /all_prices/1.json
  def destroy
    @all_price.destroy!

    respond_to do |format|
      format.html { redirect_to all_prices_path, notice: "All price was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_all_price
      @all_price = AllPrice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def all_price_params
      params.expect(all_price: [ :tv_size_id, :technician_price, :customer_price, :idadiyacof ])
    end
end
