class HomeController < ApplicationController
  def index
    # ✅ Correct eager loading
    @hero = Hero.with_attached_images.first
    @featured_tours = TravelTour.with_attached_image.where(featured: true).limit(3)
    @popular_destinations = Destination.with_attached_image.where(featured: true).limit(3)
    @testimonials = Testimonial.with_attached_avatar.order(rating: :desc).limit(3)
    @featuredvideo = Video.first

    record_visit

    @cta = default_cta
  end

  private

    def record_visit
      Visit.create(visited_at: Time.current)
    end
    def default_cta
      {
        title: "Ready for Your Next Adventure?",
        subtitle: "Join thousands of happy travelers who've explored with us",
        button_text: "Book Now",
        button_url: travel_tours_path,
        secondary_button_text: "Contact Us",
        secondary_button_url: pages_contact_path,
        background_color: "green-800"
      }
    end
end