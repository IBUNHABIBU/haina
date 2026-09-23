require "application_system_test_case"

class TravelToursTest < ApplicationSystemTestCase
  setup do
    @travel_tour = travel_tours(:one)
  end

  test "visiting the index" do
    visit travel_tours_url
    assert_selector "h1", text: "Travel tours"
  end

  test "should create travel tour" do
    visit travel_tours_url
    click_on "New travel tour"

    fill_in "Category", with: @travel_tour.category
    fill_in "Description", with: @travel_tour.description
    fill_in "Duration", with: @travel_tour.duration
    check "Featured" if @travel_tour.featured
    fill_in "Highlights", with: @travel_tour.highlights
    fill_in "Includes", with: @travel_tour.includes
    fill_in "Name", with: @travel_tour.name
    fill_in "Price", with: @travel_tour.price
    click_on "Create Travel tour"

    assert_text "Travel tour was successfully created"
    click_on "Back"
  end

  test "should update Travel tour" do
    visit travel_tour_url(@travel_tour)
    click_on "Edit this travel tour", match: :first

    fill_in "Category", with: @travel_tour.category
    fill_in "Description", with: @travel_tour.description
    fill_in "Duration", with: @travel_tour.duration
    check "Featured" if @travel_tour.featured
    fill_in "Highlights", with: @travel_tour.highlights
    fill_in "Includes", with: @travel_tour.includes
    fill_in "Name", with: @travel_tour.name
    fill_in "Price", with: @travel_tour.price
    click_on "Update Travel tour"

    assert_text "Travel tour was successfully updated"
    click_on "Back"
  end

  test "should destroy Travel tour" do
    visit travel_tour_url(@travel_tour)
    accept_confirm { click_on "Destroy this travel tour", match: :first }

    assert_text "Travel tour was successfully destroyed"
  end
end
