class Safari < ApplicationRecord
  extend FriendlyId
  
  friendly_id :title, use: [:slugged, :history, :finders]
  
  # Active Storage attachments
  has_one_attached :main_image
  has_many_attached :gallery_images
  
  # Validations
  validates :title, :duration, :difficulty, :overview_title, :overview_description, 
            :main_attractions, :best_season, :price_per_person, :min_people, :max_people,
            :departure_location, :return_location, :accommodation_type, :transport_type,
            :included_services, :excluded_services, presence: true
            
  validates :duration, :min_people, :max_people, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_person, numericality: { greater_than_or_equal_to: 0 }
  validates :difficulty, inclusion: { in: %w[easy moderate challenging] }
  validates :status, inclusion: { in: %w[active inactive seasonal] }, allow_blank: true
  
  # Image validations
  validate :acceptable_main_image
  validate :acceptable_gallery_images

  def should_generate_new_friendly_id?
    title_changed? || super
  end
  
  private
  
  def acceptable_main_image
    return unless main_image.attached?
    
    unless main_image.blob.byte_size <= 5.megabyte
      errors.add(:main_image, "is too large (max 5MB)")
    end
    
    acceptable_types = ["image/jpeg", "image/png", "image/webp"]
    unless acceptable_types.include?(main_image.blob.content_type)
      errors.add(:main_image, "must be a JPEG, PNG, or WebP image")
    end
  end
  
  def acceptable_gallery_images
    return unless gallery_images.attached?
    
    gallery_images.each do |image|
      unless image.blob.byte_size <= 5.megabyte
        errors.add(:gallery_images, "one or more images are too large (max 5MB each)")
        break
      end
      
      acceptable_types = ["image/jpeg", "image/png", "image/webp"]
      unless acceptable_types.include?(image.blob.content_type)
        errors.add(:gallery_images, "must be JPEG, PNG, or WebP images")
        break
      end
    end
  end
end