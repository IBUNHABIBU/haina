class TrekkingsController < ApplicationController
  before_action :set_trekking, only: %i[ show edit update destroy ]

  def index
    @trekkings = Trekking.with_attached_gallery_images.with_attached_main_image.all
    @gears = Gear.all
  end

  def show
  end

  def new
    @trekking = Trekking.new
  end

  def edit
  end

  def create
    @trekking = Trekking.new(trekking_params)

    if @trekking.save
      redirect_to @trekking, notice: "Trekking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @trekking.update(trekking_params)
      redirect_to @trekking, notice: "Trekking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trekking.destroy
    redirect_to trekkings_url, notice: "Trekking was successfully destroyed."
  end

  private
    def set_trekking
      @trekking = Trekking.friendly.find(params[:id])
    end

    def trekking_params
      params.require(:trekking).permit(
        :title, :duration, :difficulty, :overview_title, :overview_description, :content,
        :main_image, gallery_images: []
      )
    end
end