class TravelToursController < ApplicationController
  before_action :set_travel_tour, only: %i[ show edit update destroy ]

  # GET /travel_tours or /travel_tours.json
  def index
    @travel_tours = TravelTour.with_attached_image.with_attached_gallery_images.all
  end

  # GET /travel_tours/1 or /travel_tours/1.json
  def show
  end

  # GET /travel_tours/new
  def new
    @travel_tour = TravelTour.new
  end

  # GET /travel_tours/1/edit
  def edit
  end

  # DELETE /tours/:id/purge_image/:image_id
  def purge_image
    @tour = TravelTour.find(params[:id])
    image = @tour.gallery_images.find(params[:image_id])
    image.purge
    redirect_back fallback_location: @tour, notice: 'Image was successfully removed.'
  end

  # POST /travel_tours or /travel_tours.json
  def create
    @travel_tour = TravelTour.new(travel_tour_params)

      puts "DEBUG: Tour params: #{travel_tour_params}"
      puts "DEBUG: Tour valid? #{@travel_tour.valid?}"
      puts "DEBUG: Tour errors: #{@travel_tour.errors.full_messages}" unless @travel_tour.valid?


    respond_to do |format|
      if @travel_tour.save
        format.html { redirect_to @travel_tour, notice: "Travel tour was successfully created." }
        format.json { render :show, status: :created, location: @travel_tour }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @travel_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travel_tours/1 or /travel_tours/1.json
  def update
    respond_to do |format|
      if @travel_tour.update(travel_tour_params)
        format.html { redirect_to @travel_tour, notice: "Travel tour was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @travel_tour }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @travel_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_tours/1 or /travel_tours/1.json
  def destroy
    @travel_tour.destroy!

    respond_to do |format|
      format.html { redirect_to travel_tours_path, notice: "Travel tour was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel_tour
      @travel_tour = TravelTour.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def travel_tour_params
      params.require(:travel_tour).permit(:name, :description, :price, :duration, :category, :featured, :highlights, :includes, :image, gallery_images: [ ])
    end
end
