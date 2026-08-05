class GearsController < ApplicationController
  before_action :set_gear, only: %i[ show edit update destroy ]

  # GET /gears or /gears.json
  def index
    @gears = Gear.all
  end

  # GET /gears/1 or /gears/1.json
  def show
  end

  # GET /gears/new
  def new
    @gear = Gear.new
  end

  # GET /gears/1/edit
  def edit
  end

  # POST /gears or /gears.json
  def create
    @gear = Gear.new(gear_params)

    respond_to do |format|
      if @gear.save
        format.html { redirect_to @gear, notice: "Gear was successfully created." }
        format.json { render :show, status: :created, location: @gear }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gears/1 or /gears/1.json
  def update
    respond_to do |format|
      if @gear.update(gear_params)
        format.html { redirect_to @gear, notice: "Gear was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @gear }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gears/1 or /gears/1.json
  def destroy
    @gear.destroy!

    respond_to do |format|
      format.html { redirect_to gears_path, notice: "Gear was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gear
      @gear = Gear.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def gear_params
      params.require(:gear).permit(:content)
    end
end
