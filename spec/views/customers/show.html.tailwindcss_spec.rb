require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    assign(:customer, Customer.create!(
      name: "Name",
      phone: "Phone",
      mahali: "Mahali",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Mahali/)
    expect(rendered).to match(//)
  end
end
