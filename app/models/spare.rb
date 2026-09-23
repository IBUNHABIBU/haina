class Spare < ApplicationRecord
  belongs_to :spare_category
  has_many :activity_spares, dependent: :restrict_with_error
  has_many :activities, through: :activity_spares
  has_many :spare_purchases, dependent: :restrict_with_error

  validates :name, presence: true
  validates :unit_cost, :selling_price, :quantity, :reorder_level, numericality: { greater_than_or_equal_to: 0 }

  scope :low_stock, -> { where("quantity <= reorder_level") }

  def stock_value
    quantity.to_d * unit_cost.to_d
  end
end
