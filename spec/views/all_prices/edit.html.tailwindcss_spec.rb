require 'rails_helper'

RSpec.describe "all_prices/edit", type: :view do
  let(:all_price) {
    AllPrice.create!(
      tv_size: nil,
      technician_price: 1,
      customer_price: 1,
      idadiyacof: "MyString"
    )
  }

  before(:each) do
    assign(:all_price, all_price)
  end

  it "renders the edit all_price form" do
    render

    assert_select "form[action=?][method=?]", all_price_path(all_price), "post" do

      assert_select "input[name=?]", "all_price[tv_size_id]"

      assert_select "input[name=?]", "all_price[technician_price]"

      assert_select "input[name=?]", "all_price[customer_price]"

      assert_select "input[name=?]", "all_price[idadiyacof]"
    end
  end
end
