class HerosController < ApplicationController
  before_action :set_hero, only: [:show, :edit, :update, :destroy]

  # GET /hero
  def show
    if @hero.nil?
      redirect_to new_hero_path, notice: 'Please create your hero section'
    end
  end

  def gallery
  @hero = Hero.includes(images_attachments: :blob).first
  if @hero.nil?
    redirect_to new_hero_path, notice: 'Please create your hero section first'
  end
end

  # GET /hero/new
  def new
    @hero = Hero.new
  end

  # GET /hero/edit
  def edit
  end

  # POST /hero
  def create
    @hero = Hero.new(hero_params)

    if @hero.save
      redirect_to root_path, notice: 'Hero section was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hero
  def update
    # Remove selected images first
    if params[:hero][:images_to_remove].present?
      params[:hero][:images_to_remove].each do |signed_id|
        image = @hero.images.find_signed(signed_id)
        image.purge if image
      end
    end
    
    if @hero.update(hero_params)
      redirect_to hero_path, notice: 'Hero was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /hero
  def destroy
    @hero.destroy
    redirect_to new_hero_url, notice: 'Hero section was successfully removed.'
  end

  private
    def set_hero
      @hero = Hero.includes(images_attachments: :blob).first
    end

    def hero_params
      params.require(:hero).permit(:title, :subtitle, :description, images: [])
    end
end