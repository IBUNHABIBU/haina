require 'rails_helper'

RSpec.describe "spare_requests/index", type: :view do
  before(:each) do
    assign(:spare_requests, [
      SpareRequest.create!(
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
      ),
      SpareRequest.create!(
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
      )
    ])
  end

  it "renders a list of spare_requests" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
