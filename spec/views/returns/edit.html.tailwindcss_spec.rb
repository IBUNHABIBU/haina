require 'rails_helper'

RSpec.describe "returns/edit", type: :view do
  let(:return) {
    Return.create!(
      repair_job: nil,
      reason: "MyString",
      remarks: "MyText"
    )
  }

  before(:each) do
    assign(:return, return)
  end

  it "renders the edit return form" do
    render

    assert_select "form[action=?][method=?]", return_path(return), "post" do

      assert_select "input[name=?]", "return[repair_job_id]"

      assert_select "input[name=?]", "return[reason]"

      assert_select "textarea[name=?]", "return[remarks]"
    end
  end
end
