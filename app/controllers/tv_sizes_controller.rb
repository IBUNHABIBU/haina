class TvSizesController < ApplicationController
  before_action :set_tv_size, only: %i[ show edit update destroy ]

  # GET /tv_sizes or /tv_sizes.json
  def index
    @tv_sizes = TvSize.all
  end

  # GET /tv_sizes/1 or /tv_sizes/1.json
  def show
  end

  # GET /tv_sizes/new
  def new
    @tv_size = TvSize.new
  end

  # GET /tv_sizes/1/edit
  def edit
  end

  # POST /tv_sizes or /tv_sizes.json
  def create
    @tv_size = TvSize.new(tv_size_params)

    respond_to do |format|
      if @tv_size.save
        format.html { redirect_to @tv_size, notice: "Tv size was successfully created." }
        format.json { render :show, status: :created, location: @tv_size }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tv_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tv_sizes/1 or /tv_sizes/1.json
  def update
    respond_to do |format|
      if @tv_size.update(tv_size_params)
        format.html { redirect_to @tv_size, notice: "Tv size was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tv_size }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tv_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tv_sizes/1 or /tv_sizes/1.json
  def destroy
    @tv_size.destroy!

    respond_to do |format|
      format.html { redirect_to tv_sizes_path, notice: "Tv size was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tv_size
      @tv_size = TvSize.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tv_size_params
      params.expect(tv_size: [ :size ])
    end
end
