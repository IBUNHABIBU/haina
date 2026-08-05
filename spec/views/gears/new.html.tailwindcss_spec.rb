require 'rails_helper'

RSpec.describe "gears/new", type: :view do
  before(:each) do
    assign(:gear, Gear.new())
  end

  it "renders new gear form" do
    render

    assert_select "form[action=?][method=?]", gears_path, "post" do
    end
  end
end
