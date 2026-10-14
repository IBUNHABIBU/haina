require 'rails_helper'

RSpec.describe "blogs/show", type: :view do
  before(:each) do
    assign(:blog, Blog.create!(
      title: "Title",
      content: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
