require "test_helper"

class TrekkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trekking = trekkings(:one)
  end

  test "should get index" do
    get trekkings_url
    assert_response :success
  end

  test "should get new" do
    get new_trekking_url
    assert_response :success
  end

  test "should create trekking" do
    assert_difference("Trekking.count") do
      post trekkings_url, params: { trekking: { difficulty: @trekking.difficulty, duration: @trekking.duration, overview_description: @trekking.overview_description, overview_title: @trekking.overview_title, title: @trekking.title } }
    end

    assert_redirected_to trekking_url(Trekking.last)
  end

  test "should show trekking" do
    get trekking_url(@trekking)
    assert_response :success
  end

  test "should get edit" do
    get edit_trekking_url(@trekking)
    assert_response :success
  end

  test "should update trekking" do
    patch trekking_url(@trekking), params: { trekking: { difficulty: @trekking.difficulty, duration: @trekking.duration, overview_description: @trekking.overview_description, overview_title: @trekking.overview_title, title: @trekking.title } }
    assert_redirected_to trekking_url(@trekking)
  end

  test "should destroy trekking" do
    assert_difference("Trekking.count", -1) do
      delete trekking_url(@trekking)
    end

    assert_redirected_to trekkings_url
  end
end
