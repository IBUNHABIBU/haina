require 'rails_helper'

RSpec.describe "repair_jobs/index", type: :view do
  before(:each) do
    assign(:repair_jobs, [
      RepairJob.create!(
        customer: nil,
        tv_brand: nil,
        tv_size: nil,
        labour_price: "9.99",
        total_sale: "9.99",
        status: 2,
        tatizo: "Tatizo",
        reference: "Reference",
        motherboard_number: "Motherboard Number",
        tcon_number: "Tcon Number",
        panel_number: "Panel Number",
        cof_number: "Cof Number"
      ),
      RepairJob.create!(
        customer: nil,
        tv_brand: nil,
        tv_size: nil,
        labour_price: "9.99",
        total_sale: "9.99",
        status: 2,
        tatizo: "Tatizo",
        reference: "Reference",
        motherboard_number: "Motherboard Number",
        tcon_number: "Tcon Number",
        panel_number: "Panel Number",
        cof_number: "Cof Number"
      )
    ])
  end

  it "renders a list of repair_jobs" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Tatizo".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Reference".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Motherboard Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Tcon Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Panel Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cof Number".to_s), count: 2
  end
end
