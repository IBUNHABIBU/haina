require 'rails_helper'

RSpec.describe "customers/new", type: :view do
  before(:each) do
    assign(:customer, Customer.new(
      name: "MyString",
      phone: "MyString",
      mahali: "MyString",
      user: nil
    ))
  end

  it "renders new customer form" do
    render

    assert_select "form[action=?][method=?]", customers_path, "post" do

      assert_select "input[name=?]", "customer[name]"

      assert_select "input[name=?]", "customer[phone]"

      assert_select "input[name=?]", "customer[mahali]"

      assert_select "input[name=?]", "customer[user_id]"
    end
  end
end
