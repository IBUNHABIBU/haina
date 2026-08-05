class SafarisController < ApplicationController
  before_action :set_safari, only: %i[ show edit update destroy ]

  # GET /safaris or /safaris.json
  def index
    @safaris = Safari.with_attached_main_image.with_attached_gallery_images.all
  end

  # GET /safaris/1 or /safaris/1.json
  def show
  end

  # GET /safaris/new
  def new
    @safari = Safari.new
  end

  # GET /safaris/1/edit
  def edit
  end

  # POST /safaris or /safaris.json
  def create
    @safari = Safari.new(safari_params)

    respond_to do |format|
      if @safari.save
        format.html { redirect_to @safari, notice: "Safari was successfully created." }
        format.json { render :show, status: :created, location: @safari }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @safari.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /safaris/1 or /safaris/1.json
  def update
    respond_to do |format|
      if @safari.update(safari_params)
        format.html { redirect_to @safari, notice: "Safari was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @safari }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @safari.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safaris/1 or /safaris/1.json
  def destroy
    @safari.destroy!

    respond_to do |format|
      format.html { redirect_to safaris_path, notice: "Safari was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_safari
      @safari = Safari.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def safari_params
      params.expect(safari: [
        :title, :duration, :difficulty, :overview_title, :overview_description,
        :main_attractions, :best_season, :price_per_person, :min_people, :max_people,
        :departure_location, :return_location, :accommodation_type, :transport_type,
        :included_services, :excluded_services, :what_to_bring, :daily_activities,
        :wildlife_highlight, :is_featured, :status, :main_image_alt,
        :main_image, gallery_images: []])
    end
end
