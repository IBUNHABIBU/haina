require "test_helper"

class SafarisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @safari = safaris(:one)
  end

  test "should get index" do
    get safaris_url
    assert_response :success
  end

  test "should get new" do
    get new_safari_url
    assert_response :success
  end

  test "should create safari" do
    assert_difference("Safari.count") do
      post safaris_url, params: { safari: { accommodation_type: @safari.accommodation_type, best_season: @safari.best_season, daily_activities: @safari.daily_activities, departure_location: @safari.departure_location, difficulty: @safari.difficulty, duration: @safari.duration, excluded_services: @safari.excluded_services, included_services: @safari.included_services, is_featured: @safari.is_featured, main_attractions: @safari.main_attractions, main_image_alt: @safari.main_image_alt, max_people: @safari.max_people, min_people: @safari.min_people, overview_description: @safari.overview_description, overview_title: @safari.overview_title, price_per_person: @safari.price_per_person, return_location: @safari.return_location, status: @safari.status, title: @safari.title, transport_type: @safari.transport_type, what_to_bring: @safari.what_to_bring, wildlife_highlight: @safari.wildlife_highlight } }
    end

    assert_redirected_to safari_url(Safari.last)
  end

  test "should show safari" do
    get safari_url(@safari)
    assert_response :success
  end

  test "should get edit" do
    get edit_safari_url(@safari)
    assert_response :success
  end

  test "should update safari" do
    patch safari_url(@safari), params: { safari: { accommodation_type: @safari.accommodation_type, best_season: @safari.best_season, daily_activities: @safari.daily_activities, departure_location: @safari.departure_location, difficulty: @safari.difficulty, duration: @safari.duration, excluded_services: @safari.excluded_services, included_services: @safari.included_services, is_featured: @safari.is_featured, main_attractions: @safari.main_attractions, main_image_alt: @safari.main_image_alt, max_people: @safari.max_people, min_people: @safari.min_people, overview_description: @safari.overview_description, overview_title: @safari.overview_title, price_per_person: @safari.price_per_person, return_location: @safari.return_location, status: @safari.status, title: @safari.title, transport_type: @safari.transport_type, what_to_bring: @safari.what_to_bring, wildlife_highlight: @safari.wildlife_highlight } }
    assert_redirected_to safari_url(@safari)
  end

  test "should destroy safari" do
    assert_difference("Safari.count", -1) do
      delete safari_url(@safari)
    end

    assert_redirected_to safaris_url
  end
end
