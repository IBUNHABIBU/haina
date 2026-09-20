require 'rails_helper'

RSpec.describe "returns/show", type: :view do
  before(:each) do
    assign(:return, Return.create!(
      repair_job: nil,
      reason: "Reason",
      remarks: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Reason/)
    expect(rendered).to match(/MyText/)
  end
end
