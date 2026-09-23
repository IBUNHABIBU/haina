require 'rails_helper'

RSpec.describe "tatizos/edit", type: :view do
  let(:tatizo) {
    Tatizo.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:tatizo, tatizo)
  end

  it "renders the edit tatizo form" do
    render

    assert_select "form[action=?][method=?]", tatizo_path(tatizo), "post" do

      assert_select "input[name=?]", "tatizo[name]"
    end
  end
end
