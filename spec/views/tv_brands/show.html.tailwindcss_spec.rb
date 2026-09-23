require 'rails_helper'

RSpec.describe "tv_brands/show", type: :view do
  before(:each) do
    assign(:tv_brand, TvBrand.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
