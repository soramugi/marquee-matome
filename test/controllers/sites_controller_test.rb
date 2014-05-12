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
    session[:user_id] = users(:one).id
    post :create, site: { url: 'http://www.amazon.co.jp', title: 'amazon' }
    assert_response :redirect
  end

  test "should delete destroy" do
    site = sites(:one)
    session[:user_id] = site.user_id
    delete :destroy, id: site.id
    assert_response :redirect
  end

end
