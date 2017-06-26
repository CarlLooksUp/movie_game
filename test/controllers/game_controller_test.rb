require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_new_url
    assert_response :success
  end

  test "should get search" do
    get game_search_url
    assert_response :success
  end

  test "should get submit" do
    get game_submit_url
    assert_response :success
  end

end
