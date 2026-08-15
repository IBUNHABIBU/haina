require 'rails_helper'

RSpec.describe "activities/index", type: :view do
  before(:each) do
    assign(:activities, [
      Activity.create!(
        customer: "Customer",
        phone: "Phone",
        TV_brand: "Tv Brand",
        TV_size: 2,
        model_no: 3,
        starting_price: "9.99",
        final_price: "9.99",
        status: 4,
        spare_used: 5,
        cost_each: "9.99",
        total_cost: "9.99",
        profit: "9.99",
        remarks: "MyText",
        labour_cost: "9.99",
        user: nil
      ),
      Activity.create!(
        customer: "Customer",
        phone: "Phone",
        TV_brand: "Tv Brand",
        TV_size: 2,
        model_no: 3,
        starting_price: "9.99",
        final_price: "9.99",
        status: 4,
        spare_used: 5,
        cost_each: "9.99",
        total_cost: "9.99",
        profit: "9.99",
        remarks: "MyText",
        labour_cost: "9.99",
        user: nil
      )
    ])
  end

  it "renders a list of activities" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Customer".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Tv Brand".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
