require "application_system_test_case"

class TrekkingsTest < ApplicationSystemTestCase
  setup do
    @trekking = trekkings(:one)
  end

  test "visiting the index" do
    visit trekkings_url
    assert_selector "h1", text: "Trekkings"
  end

  test "should create trekking" do
    visit trekkings_url
    click_on "New trekking"

    fill_in "Difficulty", with: @trekking.difficulty
    fill_in "Duration", with: @trekking.duration
    fill_in "Overview description", with: @trekking.overview_description
    fill_in "Overview title", with: @trekking.overview_title
    fill_in "Title", with: @trekking.title
    click_on "Create Trekking"

    assert_text "Trekking was successfully created"
    click_on "Back"
  end

  test "should update Trekking" do
    visit trekking_url(@trekking)
    click_on "Edit this trekking", match: :first

    fill_in "Difficulty", with: @trekking.difficulty
    fill_in "Duration", with: @trekking.duration
    fill_in "Overview description", with: @trekking.overview_description
    fill_in "Overview title", with: @trekking.overview_title
    fill_in "Title", with: @trekking.title
    click_on "Update Trekking"

    assert_text "Trekking was successfully updated"
    click_on "Back"
  end

  test "should destroy Trekking" do
    visit trekking_url(@trekking)
    accept_confirm { click_on "Destroy this trekking", match: :first }

    assert_text "Trekking was successfully destroyed"
  end
end
