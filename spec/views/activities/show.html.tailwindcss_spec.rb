require 'rails_helper'

RSpec.describe "activities/show", type: :view do
  before(:each) do
    assign(:activity, Activity.create!(
      customer: "Customer",
      phone: "Phone",
      TV_brand: "Tv Brand",
      TV_size: 2,
      model_no: "Model No",
      starting_price: "9.99",
      final_price: "9.99",
      status: 3,
      spare_used: 4,
      cost_each: "9.99",
      total_cost: "9.99",
      profit: "9.99",
      remarks: "MyText",
      labour_cost: "9.99",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Customer/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Tv Brand/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Model No/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
