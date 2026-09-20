class RepairJob < ApplicationRecord
  belongs_to :customer
  belongs_to :tv_brand
  belongs_to :tv_size

  has_many :part_usages, dependent: :restrict_with_error
  has_many :payments, dependent: :restrict_with_error
  has_many :returns, dependent: :restrict_with_error

  enum :status, {
    received: 0,
    diagnosing: 1,
    waiting_parts: 2,
    bonding: 3,
    testing: 4,
    completed: 5,
    dispatched: 6,
    returned: 7,
    cancelled: 8
  }

  validates :labour_price,
            numericality: { greater_than_or_equal_to: 0 }

  validates :total_sale,
            numericality: { greater_than_or_equal_to: 0 }

  def total_parts_cost
    part_usages.sum(&:total_cost)
  end

  def net_profit
    total_sale - total_parts_cost
  end

  def return_count
    returns.count
  end
end