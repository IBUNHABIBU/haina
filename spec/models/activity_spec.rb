require "rails_helper"

RSpec.describe Activity, type: :model do
  subject(:activity) { build(:activity, price: 200_000, labour_charge: 60_000) }

  it { is_expected.to belong_to(:customer).optional }
  it { is_expected.to belong_to(:tv_brand).optional }
  it { is_expected.to belong_to(:tv_size).optional }
  it { is_expected.to belong_to(:tatizo).optional }
  it { is_expected.to have_many(:activity_spares).dependent(:destroy) }
  it { is_expected.to have_many(:repair_returns).dependent(:destroy) }

  it "calculates gross profit from price, labour and spares" do
    spare = create(:spare, quantity: 5, unit_cost: 20_000)
    activity.save!
    activity.activity_spares.create!(spare: spare, quantity: 2)

    expect(activity.reload.gross_profit).to eq(100_000)
    expect(spare.reload.quantity).to eq(3)
  end
end
