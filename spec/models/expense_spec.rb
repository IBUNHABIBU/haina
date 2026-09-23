require "rails_helper"

RSpec.describe Expense, type: :model do
  it "accepts the supported expense categories" do
    expense = build(:expense, category: "electricity")
    expect(expense).to be_valid
  end
end
