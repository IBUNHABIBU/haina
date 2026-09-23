require 'rails_helper'

RSpec.describe "tv_brands/index", type: :view do
  before(:each) do
    assign(:tv_brands, [
      TvBrand.create!(
        name: "Name"
      ),
      TvBrand.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of tv_brands" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
