require 'rails_helper'

RSpec.describe "videos/edit", type: :view do
  let(:video) {
    Video.create!(
      title: "MyString",
      duration: 1
    )
  }

  before(:each) do
    assign(:video, video)
  end

  it "renders the edit video form" do
    render

    assert_select "form[action=?][method=?]", video_path(video), "post" do

      assert_select "input[name=?]", "video[title]"

      assert_select "input[name=?]", "video[duration]"
    end
  end
end
