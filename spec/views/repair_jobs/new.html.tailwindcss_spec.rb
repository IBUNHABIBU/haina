require 'rails_helper'

RSpec.describe "repair_jobs/new", type: :view do
  before(:each) do
    assign(:repair_job, RepairJob.new(
      customer: nil,
      tv_brand: nil,
      tv_size: nil,
      labour_price: "9.99",
      total_sale: "9.99",
      status: 1,
      tatizo: "MyString",
      reference: "MyString",
      motherboard_number: "MyString",
      tcon_number: "MyString",
      panel_number: "MyString",
      cof_number: "MyString"
    ))
  end

  it "renders new repair_job form" do
    render

    assert_select "form[action=?][method=?]", repair_jobs_path, "post" do

      assert_select "input[name=?]", "repair_job[customer_id]"

      assert_select "input[name=?]", "repair_job[tv_brand_id]"

      assert_select "input[name=?]", "repair_job[tv_size_id]"

      assert_select "input[name=?]", "repair_job[labour_price]"

      assert_select "input[name=?]", "repair_job[total_sale]"

      assert_select "input[name=?]", "repair_job[status]"

      assert_select "input[name=?]", "repair_job[tatizo]"

      assert_select "input[name=?]", "repair_job[reference]"

      assert_select "input[name=?]", "repair_job[motherboard_number]"

      assert_select "input[name=?]", "repair_job[tcon_number]"

      assert_select "input[name=?]", "repair_job[panel_number]"

      assert_select "input[name=?]", "repair_job[cof_number]"
    end
  end
end
