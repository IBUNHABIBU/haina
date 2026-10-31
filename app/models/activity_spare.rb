class ActivitySpare < ApplicationRecord
  belongs_to :activity
  belongs_to :spare

  validates :quantity,
            numericality: { only_integer: true, greater_than: 0 }

  validates :unit_cost,
            numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_unit_cost, on: :create
  before_validation :calculate_total_cost

  validate :stock_is_available

  after_create :consume_stock_and_recalculate
  after_update :adjust_stock_and_recalculate
  after_destroy :restore_stock_and_recalculate

  private

  def set_unit_cost
    self.unit_cost = spare.unit_cost if spare.present?
  end

  def calculate_total_cost
    self.total_cost = quantity.to_d * unit_cost.to_d
  end

  def stock_is_available
    return unless spare && quantity.present?
    return if quantity.to_i <= 0

    available = spare.quantity.to_i

    if persisted? && !will_save_change_to_spare_id?
      available += quantity_in_database.to_i
    end

    if quantity.to_i > available
      errors.add(:quantity, "exceeds available stock")
    end
  end

  def consume_stock_and_recalculate
    spare.with_lock do
      spare.update!(quantity: spare.quantity - quantity)
    end

    activity.recalculate_gross_profit!
  end

  def adjust_stock_and_recalculate
    if saved_change_to_quantity?
      previous_quantity = quantity_before_last_save
      difference = quantity - previous_quantity

      spare.with_lock do
        spare.update!(quantity: spare.quantity - difference)
      end
    end

    activity.recalculate_gross_profit!
  end

  def restore_stock_and_recalculate
    spare.with_lock do
      spare.update!(quantity: spare.quantity + quantity)
    end

    activity.recalculate_gross_profit!
  end
end