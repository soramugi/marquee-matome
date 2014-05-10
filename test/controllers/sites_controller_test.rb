require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: sites(:one).id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    post :create
    assert_response :redirect
  end

  test "should delete destroy" do
    delete :destroy, id: sites(:one).id
    assert_response :redirect
  end

end