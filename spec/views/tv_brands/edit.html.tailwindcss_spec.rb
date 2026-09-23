require 'rails_helper'

RSpec.describe "tv_brands/edit", type: :view do
  let(:tv_brand) {
    TvBrand.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:tv_brand, tv_brand)
  end

  it "renders the edit tv_brand form" do
    render

    assert_select "form[action=?][method=?]", tv_brand_path(tv_brand), "post" do

      assert_select "input[name=?]", "tv_brand[name]"
    end
  end
end
