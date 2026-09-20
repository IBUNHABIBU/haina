require 'rails_helper'

RSpec.describe "repair_jobs/show", type: :view do
  before(:each) do
    assign(:repair_job, RepairJob.create!(
      customer: nil,
      tv_brand: nil,
      tv_size: nil,
      labour_price: "9.99",
      total_sale: "9.99",
      status: 2,
      tatizo: "Tatizo",
      reference: "Reference",
      motherboard_number: "Motherboard Number",
      tcon_number: "Tcon Number",
      panel_number: "Panel Number",
      cof_number: "Cof Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Tatizo/)
    expect(rendered).to match(/Reference/)
    expect(rendered).to match(/Motherboard Number/)
    expect(rendered).to match(/Tcon Number/)
    expect(rendered).to match(/Panel Number/)
    expect(rendered).to match(/Cof Number/)
  end
end
