require 'rails_helper'

RSpec.describe "gears/edit", type: :view do
  let(:gear) {
    Gear.create!()
  }

  before(:each) do
    assign(:gear, gear)
  end

  it "renders the edit gear form" do
    render

    assert_select "form[action=?][method=?]", gear_path(gear), "post" do
    end
  end
end
