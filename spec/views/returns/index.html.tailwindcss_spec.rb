require 'rails_helper'

RSpec.describe "returns/index", type: :view do
  before(:each) do
    assign(:returns, [
      Return.create!(
        repair_job: nil,
        reason: "Reason",
        remarks: "MyText"
      ),
      Return.create!(
        repair_job: nil,
        reason: "Reason",
        remarks: "MyText"
      )
    ])
  end

  it "renders a list of returns" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Reason".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
