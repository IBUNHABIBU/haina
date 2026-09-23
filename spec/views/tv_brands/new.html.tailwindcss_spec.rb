require 'rails_helper'

RSpec.describe "tv_brands/new", type: :view do
  before(:each) do
    assign(:tv_brand, TvBrand.new(
      name: "MyString"
    ))
  end

  it "renders new tv_brand form" do
    render

    assert_select "form[action=?][method=?]", tv_brands_path, "post" do

      assert_select "input[name=?]", "tv_brand[name]"
    end
  end
end
