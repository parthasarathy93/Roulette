require 'test_helper'

class GameHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_history = game_histories(:one)
  end

  test "should get index" do
    get game_histories_url, as: :json
    assert_response :success
  end

  test "should create game_history" do
    assert_difference('GameHistory.count') do
      post game_histories_url, params: { game_history: { game_id: @game_history.game_id, gametime: @game_history.gametime, user_id: @game_history.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show game_history" do
    get game_history_url(@game_history), as: :json
    assert_response :success
  end

  test "should update game_history" do
    patch game_history_url(@game_history), params: { game_history: { game_id: @game_history.game_id, gametime: @game_history.gametime, user_id: @game_history.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy game_history" do
    assert_difference('GameHistory.count', -1) do
      delete game_history_url(@game_history), as: :json
    end

    assert_response 204
  end
end
