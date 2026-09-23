class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :tv_brand, optional: true
  belongs_to :tv_size, optional: true
  belongs_to :tatizo, optional: true

  has_many :activity_spares, dependent: :destroy
  has_many :spares, through: :activity_spares
  has_many :repair_returns, dependent: :destroy

  has_one_attached :pattern_image
  has_one_attached :model_image
  has_one_attached :board_number
  has_one_attached :tcon_number
  has_one_attached :cof_number
  has_one_attached :panel_number
  has_one_attached :image_before
  has_one_attached :image_after

  enum :status, {
    received: 0,
    diagnosing: 1,
    waiting_for_parts: 2,
    in_repair: 3,
    completed: 4,
    delivered: 5,
    returned: 6,
    irreparable: 7,
    cancelled: 8
  }

  before_validation :calculate_gross_profit

  validates :price, :labour_charge, numericality: { greater_than_or_equal_to: 0 }

  scope :sales, -> { where(status: %i[completed delivered returned]) }

  def spare_cost
    activity_spares.sum(:total_cost).to_d
  end

  def gross_profit_value
    price.to_d - labour_charge.to_d - spare_cost
  end

  def calculate_gross_profit
    self.gross_profit = gross_profit_value
  end
end
