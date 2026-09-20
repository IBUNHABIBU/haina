require 'rails_helper'

RSpec.describe "tatizos/new", type: :view do
  before(:each) do
    assign(:tatizo, Tatizo.new(
      name: "MyString"
    ))
  end

  it "renders new tatizo form" do
    render

    assert_select "form[action=?][method=?]", tatizos_path, "post" do

      assert_select "input[name=?]", "tatizo[name]"
    end
  end
end
