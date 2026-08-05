class TeamMember < ApplicationRecord
  validates :name, :title, :bio, presence: true
  validates :display_order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  # For photo uploads (if you want to use Active Storage later)
  has_one_attached :photo

  # Default scope for ordering
  default_scope { order(display_order: :asc, created_at: :desc) }
end