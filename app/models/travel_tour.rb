class TravelTour < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]
  

  CATEGORIES = ['Adventure', 'Cultural', 'Wildlife', 'Beach', 'Hiking', 'Luxury'].freeze
  
  has_one_attached :image
  has_many_attached :gallery_images

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }
 

  scope :featured, -> { where(featured: true) }

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end