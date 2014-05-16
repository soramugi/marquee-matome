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

  test "should get new not login" do
    get :new
    assert_response 404
  end

  test "should get new" do
    login(users(:one))
    get :new
    assert_response :success
  end

  test "should get confirm not login" do
    get :new, site: { url: 'huge' }
    assert_response 404
    get :new, site: { url: 'http://www.amazon.co.jp' }
    assert_response 404
  end

  test "should get confirm" do
    login(users(:one))
    get :new, site: { url: 'huge' }
    assert_response :success
    get :new, site: { url: 'http://www.amazon.co.jp' }
    assert_response :success
  end

  test "should post create" do
    login(users(:one))
    assert_difference('Site.count') do
      post :create, site: { url: 'http://www.amazon.co.jp' }
    end
    assert_response :redirect
  end

  test "should delete destroy" do
    site = sites(:one)
    login(site.user)
    assert_difference('Site.count', -1) do
      delete :destroy, id: site.id
    end
    assert_response :redirect
  end

  test "should delete destroy error" do
    site = sites(:one)
    user = User.where.not(id: site.user.id).first
    login(user)
    assert_no_difference('Site.count', -1) do
      delete :destroy, id: site.id
    end
    assert_response :success
  end

end
