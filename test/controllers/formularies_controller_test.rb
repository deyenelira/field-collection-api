require 'test_helper'

class FormulariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formulary = formularies(:one)
  end

  test "should get index" do
    get formularies_url, as: :json
    assert_response :success
  end

  test "should create formulary" do
    assert_difference('Formulary.count') do
      post formularies_url, params: { formulary: { name: @formulary.name } }, as: :json
    end

    assert_response 201
  end

  test "should show formulary" do
    get formulary_url(@formulary), as: :json
    assert_response :success
  end

  test "should update formulary" do
    patch formulary_url(@formulary), params: { formulary: { name: @formulary.name } }, as: :json
    assert_response 200
  end

  test "should destroy formulary" do
    assert_difference('Formulary.count', -1) do
      delete formulary_url(@formulary), as: :json
    end

    assert_response 204
  end
end
