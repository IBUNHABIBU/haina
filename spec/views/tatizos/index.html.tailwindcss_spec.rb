require 'rails_helper'

RSpec.describe "tatizos/index", type: :view do
  before(:each) do
    assign(:tatizos, [
      Tatizo.create!(
        name: "Name"
      ),
      Tatizo.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of tatizos" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
