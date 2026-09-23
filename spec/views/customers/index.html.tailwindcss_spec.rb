require 'rails_helper'

RSpec.describe "customers/index", type: :view do
  before(:each) do
    assign(:customers, [
      Customer.create!(
        name: "Name",
        phone: "Phone",
        mahali: "Mahali",
        user: nil
      ),
      Customer.create!(
        name: "Name",
        phone: "Phone",
        mahali: "Mahali",
        user: nil
      )
    ])
  end

  it "renders a list of customers" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Mahali".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
