require 'rails_helper'

RSpec.describe "returns/new", type: :view do
  before(:each) do
    assign(:return, Return.new(
      repair_job: nil,
      reason: "MyString",
      remarks: "MyText"
    ))
  end

  it "renders new return form" do
    render

    assert_select "form[action=?][method=?]", returns_path, "post" do

      assert_select "input[name=?]", "return[repair_job_id]"

      assert_select "input[name=?]", "return[reason]"

      assert_select "textarea[name=?]", "return[remarks]"
    end
  end
end
