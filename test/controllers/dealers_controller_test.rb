require 'test_helper'

class DealersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dealer = dealers(:one)
  end

  test "should get index" do
    get dealers_url, as: :json
    assert_response :success
  end

  test "should create dealer" do
    assert_difference('Dealer.count') do
      post dealers_url, params: { dealer: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show dealer" do
    get dealer_url(@dealer), as: :json
    assert_response :success
  end

  test "should update dealer" do
    patch dealer_url(@dealer), params: { dealer: {  } }, as: :json
    assert_response 200
  end

  test "should destroy dealer" do
    assert_difference('Dealer.count', -1) do
      delete dealer_url(@dealer), as: :json
    end

    assert_response 204
  end
end
