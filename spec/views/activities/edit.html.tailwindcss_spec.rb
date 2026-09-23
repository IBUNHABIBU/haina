require 'rails_helper'

RSpec.describe "activities/edit", type: :view do
  let(:activity) {
    Activity.create!(
      customer: "MyString",
      phone: "MyString",
      TV_brand: "MyString",
      TV_size: 1,
      model_no: "MyString",
      starting_price: "9.99",
      final_price: "9.99",
      status: 1,
      spare_used: 1,
      cost_each: "9.99",
      total_cost: "9.99",
      profit: "9.99",
      remarks: "MyText",
      labour_cost: "9.99",
      user: nil
    )
  }

  before(:each) do
    assign(:activity, activity)
  end

  it "renders the edit activity form" do
    render

    assert_select "form[action=?][method=?]", activity_path(activity), "post" do

      assert_select "input[name=?]", "activity[customer]"

      assert_select "input[name=?]", "activity[phone]"

      assert_select "input[name=?]", "activity[TV_brand]"

      assert_select "input[name=?]", "activity[TV_size]"

      assert_select "input[name=?]", "activity[model_no]"

      assert_select "input[name=?]", "activity[starting_price]"

      assert_select "input[name=?]", "activity[final_price]"

      assert_select "input[name=?]", "activity[status]"

      assert_select "input[name=?]", "activity[spare_used]"

      assert_select "input[name=?]", "activity[cost_each]"

      assert_select "input[name=?]", "activity[total_cost]"

      assert_select "input[name=?]", "activity[profit]"

      assert_select "textarea[name=?]", "activity[remarks]"

      assert_select "input[name=?]", "activity[labour_cost]"

      assert_select "input[name=?]", "activity[user_id]"
    end
  end
end
