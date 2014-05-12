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

  test "should get confirm" do
    get :new, site: { url: 'http://www.amazon.co.jp', title: 'amazon' }
    assert_response :success
    get :new, site: { url: 'huge' }
    assert_response :success
  end

  test "should post create" do
    session[:user_id] = users(:one).id
    post :create, site: { url: 'http://www.amazon.co.jp', title: 'amazon' }
    assert_response :redirect
  end

  test "should delete destroy" do
    site = sites(:one)
    user = site.user
    session[:user_id] = user.id
    session[:name]    = user.name
    delete :destroy, id: site.id
    assert_response :redirect
  end

end
