class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :edit, :update, :destroy]

  def index
    @destinations = Destination.with_attached_image.all
  end

  def show
  end

  def new
    @destination = Destination.new
  end

  def edit
  end

  def create
    @destination = Destination.new(destination_params)

    if @destination.save
      redirect_to root_path, notice: 'Destination was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @destination.update(destination_params)
      redirect_to @destination, notice: 'Destination was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @destination.destroy
    redirect_to destinations_url, notice: 'Destination was successfully destroyed.'
  end

  private

  def set_destination
    @destination = Destination.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :country, :description, :featured, :image)
  end
end
