require "test_helper"

class TravelToursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @travel_tour = travel_tours(:one)
  end

  test "should get index" do
    get travel_tours_url
    assert_response :success
  end

  test "should get new" do
    get new_travel_tour_url
    assert_response :success
  end

  test "should create travel_tour" do
    assert_difference("TravelTour.count") do
      post travel_tours_url, params: { travel_tour: { category: @travel_tour.category, description: @travel_tour.description, duration: @travel_tour.duration, featured: @travel_tour.featured, highlights: @travel_tour.highlights, includes: @travel_tour.includes, name: @travel_tour.name, price: @travel_tour.price } }
    end

    assert_redirected_to travel_tour_url(TravelTour.last)
  end

  test "should show travel_tour" do
    get travel_tour_url(@travel_tour)
    assert_response :success
  end

  test "should get edit" do
    get edit_travel_tour_url(@travel_tour)
    assert_response :success
  end

  test "should update travel_tour" do
    patch travel_tour_url(@travel_tour), params: { travel_tour: { category: @travel_tour.category, description: @travel_tour.description, duration: @travel_tour.duration, featured: @travel_tour.featured, highlights: @travel_tour.highlights, includes: @travel_tour.includes, name: @travel_tour.name, price: @travel_tour.price } }
    assert_redirected_to travel_tour_url(@travel_tour)
  end

  test "should destroy travel_tour" do
    assert_difference("TravelTour.count", -1) do
      delete travel_tour_url(@travel_tour)
    end

    assert_redirected_to travel_tours_url
  end
end
