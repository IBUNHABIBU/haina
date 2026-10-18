require 'rails_helper'

RSpec.describe "all_prices/new", type: :view do
  before(:each) do
    assign(:all_price, AllPrice.new(
      tv_size: nil,
      technician_price: 1,
      customer_price: 1,
      idadiyacof: "MyString"
    ))
  end

  it "renders new all_price form" do
    render

    assert_select "form[action=?][method=?]", all_prices_path, "post" do

      assert_select "input[name=?]", "all_price[tv_size_id]"

      assert_select "input[name=?]", "all_price[technician_price]"

      assert_select "input[name=?]", "all_price[customer_price]"

      assert_select "input[name=?]", "all_price[idadiyacof]"
    end
  end
end
