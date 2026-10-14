require 'rails_helper'

RSpec.describe "blogs/new", type: :view do
  before(:each) do
    assign(:blog, Blog.new(
      title: "MyString",
      content: nil
    ))
  end

  it "renders new blog form" do
    render

    assert_select "form[action=?][method=?]", blogs_path, "post" do

      assert_select "input[name=?]", "blog[title]"

      assert_select "input[name=?]", "blog[content]"
    end
  end
end
