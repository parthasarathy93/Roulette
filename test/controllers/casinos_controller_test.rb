require 'test_helper'

class CasinosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @casino = casinos(:one)
  end

  test "should get index" do
    get casinos_url, as: :json
    assert_response :success
  end

  test "should create casino" do
    assert_difference('Casino.count') do
      post casinos_url, params: { casino: { balance: @casino.balance, crdate: @casino.crdate, name: @casino.name } }, as: :json
    end

    assert_response 201
  end

  test "should show casino" do
    get casino_url(@casino), as: :json
    assert_response :success
  end

  test "should update casino" do
    patch casino_url(@casino), params: { casino: { balance: @casino.balance, crdate: @casino.crdate, name: @casino.name } }, as: :json
    assert_response 200
  end

  test "should destroy casino" do
    assert_difference('Casino.count', -1) do
      delete casino_url(@casino), as: :json
    end

    assert_response 204
  end
end
