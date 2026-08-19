class Activity < ApplicationRecord
  belongs_to :user
  before_validation :calculate_total

  enum :status, {
    received: 0,
    completed: 1,
    returned: 2,
    irepairable: 3
  }

    has_one_attached :pattern_image
    has_one_attached :model_image
    has_one_attached :board_number
    has_one_attached :tcon_number
    has_one_attached :cof_number
    has_one_attached :panel_number
    has_one_attached :image_before
    has_one_attached :image_after

  private

  def calculate_total
    self.total_cost = spare_used.to_d * cost_each.to_d
    self.labour_cost = final_price.to_d * 0.30
    self.profit = final_price.to_d - total_cost.to_d - labour_cost.to_d
  end
end
