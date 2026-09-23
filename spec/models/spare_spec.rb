require "rails_helper"

RSpec.describe Spare, type: :model do
  it "identifies low-stock items" do
    low = create(:spare, quantity: 2, reorder_level: 2)
    normal = create(:spare, quantity: 5, reorder_level: 2)

    expect(Spare.low_stock).to include(low)
    expect(Spare.low_stock).not_to include(normal)
  end
end
