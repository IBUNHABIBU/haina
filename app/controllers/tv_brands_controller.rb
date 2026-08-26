class TvBrandsController < ApplicationController
  before_action :set_tv_brand, only: %i[ show edit update destroy ]

  # GET /tv_brands or /tv_brands.json
  def index
    @tv_brands = TvBrand.all
  end

  # GET /tv_brands/1 or /tv_brands/1.json
  def show
  end

  # GET /tv_brands/new
  def new
    @tv_brand = TvBrand.new
  end

  # GET /tv_brands/1/edit
  def edit
  end

  # POST /tv_brands or /tv_brands.json
  def create
    @tv_brand = TvBrand.new(tv_brand_params)

    respond_to do |format|
      if @tv_brand.save
        format.html { redirect_to @tv_brand, notice: "Tv brand was successfully created." }
        format.json { render :show, status: :created, location: @tv_brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tv_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tv_brands/1 or /tv_brands/1.json
  def update
    respond_to do |format|
      if @tv_brand.update(tv_brand_params)
        format.html { redirect_to @tv_brand, notice: "Tv brand was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tv_brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tv_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tv_brands/1 or /tv_brands/1.json
  def destroy
    @tv_brand.destroy!

    respond_to do |format|
      format.html { redirect_to tv_brands_path, notice: "Tv brand was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tv_brand
      @tv_brand = TvBrand.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tv_brand_params
      params.expect(tv_brand: [ :name ])
    end
end
