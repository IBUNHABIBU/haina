require 'rails_helper'

RSpec.describe "tv_sizes/show", type: :view do
  before(:each) do
    assign(:tv_size, TvSize.create!(
      size: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
  end
end
