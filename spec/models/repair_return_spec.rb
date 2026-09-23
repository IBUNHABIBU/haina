require "rails_helper"

RSpec.describe RepairReturn, type: :model do
  it "numbers returns independently for the same repair" do
    activity = create(:activity)
    first = create(:repair_return, activity: activity)
    second = create(:repair_return, activity: activity)

    expect([first.return_number, second.return_number]).to eq([1, 2])
    expect(activity.reload.returned_count).to eq(2)
  end
end
