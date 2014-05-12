require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, name: users(:one).name
    assert_response :success
  end

end
