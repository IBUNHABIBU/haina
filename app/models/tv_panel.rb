class TvPanel < ApplicationRecord
  belongs_to :tv_brand
  belongs_to :tv_size
  belongs_to :customer

  enum :status, {
    instock: 0,
    sold: 1,
  }

  # Picha za Bango
  has_one_attached :front_image
  has_one_attached :back_image
  
  def profit
    sell_price.to_d - buy_price.to_d
  end

  # Scope kwa ajili ya Dashboard (mabango yaliyouzwa tu)
  scope :sold_between, ->(range) { where(status: "sold", sold_at: range) }
  
end
