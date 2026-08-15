class Activity < ApplicationRecord
  belongs_to :user

  def calculate_total
    self.total_cost = spare_used * cost_each
    self.labour_cost = final_price * 0.30
    self.profit = final_price - total_cost - labour_cost 
  end
end
