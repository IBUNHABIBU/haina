require 'rails_helper'

RSpec.describe "spare_requests/show", type: :view do
  before(:each) do
    assign(:spare_request, SpareRequest.create!(
      activity: nil,
      spare: nil,
      requested_by: nil,
      issued_by: nil,
      requested_quantity: 2,
      issued_quantity: 3,
      unit_cost_at_issue: "9.99",
      status: "Status",
      reason: "MyText",
      store_notes: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
