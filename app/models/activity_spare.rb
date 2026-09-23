class ActivitySpare < ApplicationRecord
  belongs_to :activity
  belongs_to :spare

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_cost, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_unit_cost, on: :create
  before_validation :calculate_total_cost
  validate :stock_is_available, on: :create
  after_create :consume_stock_and_recalculate
  after_destroy :restore_stock_and_recalculate

  private

  def set_unit_cost
    self.unit_cost ||= spare.unit_cost
  end

  def calculate_total_cost
    self.total_cost = quantity.to_d * unit_cost.to_d
  end

  def stock_is_available
    errors.add(:quantity, "exceeds available stock") if spare && quantity.to_i > spare.quantity.to_i
  end

  def consume_stock_and_recalculate
    spare.with_lock { spare.update!(quantity: spare.quantity - quantity) }
    activity.update_column(:gross_profit, activity.gross_profit_value)
  end

  def restore_stock_and_recalculate
    spare.with_lock { spare.update!(quantity: spare.quantity + quantity) }
    activity.update_column(:gross_profit, activity.gross_profit_value)
  end
end
