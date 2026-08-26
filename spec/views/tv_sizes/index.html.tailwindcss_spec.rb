require 'rails_helper'

RSpec.describe "tv_sizes/index", type: :view do
  before(:each) do
    assign(:tv_sizes, [
      TvSize.create!(
        size: "9.99"
      ),
      TvSize.create!(
        size: "9.99"
      )
    ])
  end

  it "renders a list of tv_sizes" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
  end
end
