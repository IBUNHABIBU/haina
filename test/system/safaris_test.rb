require "application_system_test_case"

class SafarisTest < ApplicationSystemTestCase
  setup do
    @safari = safaris(:one)
  end

  test "visiting the index" do
    visit safaris_url
    assert_selector "h1", text: "Safaris"
  end

  test "should create safari" do
    visit safaris_url
    click_on "New safari"

    fill_in "Accommodation type", with: @safari.accommodation_type
    fill_in "Best season", with: @safari.best_season
    fill_in "Daily activities", with: @safari.daily_activities
    fill_in "Departure location", with: @safari.departure_location
    fill_in "Difficulty", with: @safari.difficulty
    fill_in "Duration", with: @safari.duration
    fill_in "Excluded services", with: @safari.excluded_services
    fill_in "Included services", with: @safari.included_services
    check "Is featured" if @safari.is_featured
    fill_in "Main attractions", with: @safari.main_attractions
    fill_in "Main image alt", with: @safari.main_image_alt
    fill_in "Max people", with: @safari.max_people
    fill_in "Min people", with: @safari.min_people
    fill_in "Overview description", with: @safari.overview_description
    fill_in "Overview title", with: @safari.overview_title
    fill_in "Price per person", with: @safari.price_per_person
    fill_in "Return location", with: @safari.return_location
    fill_in "Status", with: @safari.status
    fill_in "Title", with: @safari.title
    fill_in "Transport type", with: @safari.transport_type
    fill_in "What to bring", with: @safari.what_to_bring
    fill_in "Wildlife highlight", with: @safari.wildlife_highlight
    click_on "Create Safari"

    assert_text "Safari was successfully created"
    click_on "Back"
  end

  test "should update Safari" do
    visit safari_url(@safari)
    click_on "Edit this safari", match: :first

    fill_in "Accommodation type", with: @safari.accommodation_type
    fill_in "Best season", with: @safari.best_season
    fill_in "Daily activities", with: @safari.daily_activities
    fill_in "Departure location", with: @safari.departure_location
    fill_in "Difficulty", with: @safari.difficulty
    fill_in "Duration", with: @safari.duration
    fill_in "Excluded services", with: @safari.excluded_services
    fill_in "Included services", with: @safari.included_services
    check "Is featured" if @safari.is_featured
    fill_in "Main attractions", with: @safari.main_attractions
    fill_in "Main image alt", with: @safari.main_image_alt
    fill_in "Max people", with: @safari.max_people
    fill_in "Min people", with: @safari.min_people
    fill_in "Overview description", with: @safari.overview_description
    fill_in "Overview title", with: @safari.overview_title
    fill_in "Price per person", with: @safari.price_per_person
    fill_in "Return location", with: @safari.return_location
    fill_in "Status", with: @safari.status
    fill_in "Title", with: @safari.title
    fill_in "Transport type", with: @safari.transport_type
    fill_in "What to bring", with: @safari.what_to_bring
    fill_in "Wildlife highlight", with: @safari.wildlife_highlight
    click_on "Update Safari"

    assert_text "Safari was successfully updated"
    click_on "Back"
  end

  test "should destroy Safari" do
    visit safari_url(@safari)
    accept_confirm { click_on "Destroy this safari", match: :first }

    assert_text "Safari was successfully destroyed"
  end
end
