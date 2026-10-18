require 'rails_helper'

RSpec.describe "all_prices/show", type: :view do
  before(:each) do
    assign(:all_price, AllPrice.create!(
      tv_size: nil,
      technician_price: 2,
      customer_price: 3,
      idadiyacof: "Idadiyacof"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Idadiyacof/)
  end
end
