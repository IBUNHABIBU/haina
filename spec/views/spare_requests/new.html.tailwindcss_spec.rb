require 'rails_helper'

RSpec.describe "spare_requests/new", type: :view do
  before(:each) do
    assign(:spare_request, SpareRequest.new(
      activity: nil,
      spare: nil,
      requested_by: nil,
      issued_by: nil,
      requested_quantity: 1,
      issued_quantity: 1,
      unit_cost_at_issue: "9.99",
      status: "MyString",
      reason: "MyText",
      store_notes: "MyText"
    ))
  end

  it "renders new spare_request form" do
    render

    assert_select "form[action=?][method=?]", spare_requests_path, "post" do

      assert_select "input[name=?]", "spare_request[activity_id]"

      assert_select "input[name=?]", "spare_request[spare_id]"

      assert_select "input[name=?]", "spare_request[requested_by_id]"

      assert_select "input[name=?]", "spare_request[issued_by_id]"

      assert_select "input[name=?]", "spare_request[requested_quantity]"

      assert_select "input[name=?]", "spare_request[issued_quantity]"

      assert_select "input[name=?]", "spare_request[unit_cost_at_issue]"

      assert_select "input[name=?]", "spare_request[status]"

      assert_select "textarea[name=?]", "spare_request[reason]"

      assert_select "textarea[name=?]", "spare_request[store_notes]"
    end
  end
end
