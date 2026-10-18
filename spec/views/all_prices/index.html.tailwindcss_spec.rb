require 'rails_helper'

RSpec.describe "all_prices/index", type: :view do
  before(:each) do
    assign(:all_prices, [
      AllPrice.create!(
        tv_size: nil,
        technician_price: 2,
        customer_price: 3,
        idadiyacof: "Idadiyacof"
      ),
      AllPrice.create!(
        tv_size: nil,
        technician_price: 2,
        customer_price: 3,
        idadiyacof: "Idadiyacof"
      )
    ])
  end

  it "renders a list of all_prices" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Idadiyacof".to_s), count: 2
  end
end
