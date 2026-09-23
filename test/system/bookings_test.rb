require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  setup do
    @booking = bookings(:one)
  end

  test "visiting the index" do
    visit bookings_url
    assert_selector "h1", text: "Bookings"
  end

  test "should create booking" do
    visit bookings_url
    click_on "New booking"

    fill_in "Email", with: @booking.email
    fill_in "End date", with: @booking.end_date
    fill_in "Full name", with: @booking.full_name
    fill_in "Number of people", with: @booking.number_of_people
    fill_in "Phone", with: @booking.phone
    fill_in "Special requests", with: @booking.special_requests
    fill_in "Start date", with: @booking.start_date
    fill_in "Status", with: @booking.status
    fill_in "Trek name", with: @booking.trek_name
    click_on "Create Booking"

    assert_text "Booking was successfully created"
    click_on "Back"
  end

  test "should update Booking" do
    visit booking_url(@booking)
    click_on "Edit this booking", match: :first

    fill_in "Email", with: @booking.email
    fill_in "End date", with: @booking.end_date
    fill_in "Full name", with: @booking.full_name
    fill_in "Number of people", with: @booking.number_of_people
    fill_in "Phone", with: @booking.phone
    fill_in "Special requests", with: @booking.special_requests
    fill_in "Start date", with: @booking.start_date
    fill_in "Status", with: @booking.status
    fill_in "Trek name", with: @booking.trek_name
    click_on "Update Booking"

    assert_text "Booking was successfully updated"
    click_on "Back"
  end

  test "should destroy Booking" do
    visit booking_url(@booking)
    accept_confirm { click_on "Destroy this booking", match: :first }

    assert_text "Booking was successfully destroyed"
  end
end
