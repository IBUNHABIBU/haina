class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]

  def index
    @testimonials = Testimonial.with_attached_avatar.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @testimonial = Testimonial.new
  end

  def edit
  end

  def create
    @testimonial = Testimonial.friendly.new(testimonial_params)

    if @testimonial.save
      redirect_to root_path, notice: 'Testimonial was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to @testimonial, notice: 'Testimonial was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @testimonial.destroy
    redirect_to testimonials_url, notice: 'Testimonial was successfully destroyed.'
  end

  private
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end

    def testimonial_params
      params.require(:testimonial).permit(:author_name, :author_title, :content, :rating, :avatar)
    end
end