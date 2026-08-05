require 'rails_helper'

RSpec.describe "videos/show", type: :view do
  before(:each) do
    assign(:video, Video.create!(
      title: "Title",
      duration: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
  end
end
