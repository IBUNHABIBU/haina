require 'rails_helper'

RSpec.describe "tv_sizes/edit", type: :view do
  let(:tv_size) {
    TvSize.create!(
      size: "9.99"
    )
  }

  before(:each) do
    assign(:tv_size, tv_size)
  end

  it "renders the edit tv_size form" do
    render

    assert_select "form[action=?][method=?]", tv_size_path(tv_size), "post" do

      assert_select "input[name=?]", "tv_size[size]"
    end
  end
end
