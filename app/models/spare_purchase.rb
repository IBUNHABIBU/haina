class SparePurchase < ApplicationRecord
  belongs_to :spare
  belongs_to :user, optional: true

  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :purchased_on, presence: true

  before_validation :calculate_total_cost
  after_create :increase_stock

  private

  def calculate_total_cost
    self.total_cost = quantity.to_d * unit_cost.to_d
  end

  def increase_stock
    spare.with_lock do
      spare.update!(quantity: spare.quantity + quantity, unit_cost: unit_cost)
    end
  end
end
