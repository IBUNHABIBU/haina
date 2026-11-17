class TvPanel < ApplicationRecord
  belongs_to :tv_brand
  belongs_to :tv_size
  belongs_to :customer

  enum :status, {
    instock: 0,
    sold: 1,
  }

  
  def profit
    sell_price.to_d - buy_price.to_d
  end

  # Scope kwa ajili ya Dashboard (mabango yaliyouzwa tu)
  scope :sold_between, ->(range) { where(status: "sold", sold_at: range) }
  
end
