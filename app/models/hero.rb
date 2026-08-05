class Hero < ApplicationRecord
  has_many_attached :images

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :description, presence: true

  # Ensure only one hero section exists
  after_create :ensure_single_hero

  private

  def ensure_single_hero
    Hero.where.not(id: id).destroy_all
  end
end
