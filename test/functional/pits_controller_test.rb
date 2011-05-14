require 'test_helper'

class PitsControllerTest < ActionController::TestCase
  setup do
    @pit = pits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pit" do
    assert_difference('Pit.count') do
      post :create, :pit => @pit.attributes
    end

    assert_redirected_to pit_path(assigns(:pit))
  end

  test "should show pit" do
    get :show, :id => @pit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pit.to_param
    assert_response :success
  end

  test "should update pit" do
    put :update, :id => @pit.to_param, :pit => @pit.attributes
    assert_redirected_to pit_path(assigns(:pit))
  end

  test "should destroy pit" do
    assert_difference('Pit.count', -1) do
      delete :destroy, :id => @pit.to_param
    end

    assert_redirected_to pits_path
  end
end
