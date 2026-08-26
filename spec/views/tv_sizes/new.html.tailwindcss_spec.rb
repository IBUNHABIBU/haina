require 'rails_helper'

RSpec.describe "tv_sizes/new", type: :view do
  before(:each) do
    assign(:tv_size, TvSize.new(
      size: "9.99"
    ))
  end

  it "renders new tv_size form" do
    render

    assert_select "form[action=?][method=?]", tv_sizes_path, "post" do

      assert_select "input[name=?]", "tv_size[size]"
    end
  end
end
