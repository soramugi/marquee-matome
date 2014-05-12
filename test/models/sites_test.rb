require 'test_helper'

class SitesTest < ActiveSupport::TestCase
  test "create" do
    user = users(:one)
    url = 'http://www.favmedia.me/soramugi'
    assert_equal [], Site.create(url: url, user_id: user.id).errors.to_a
    assert_equal ["Url が重複しています"], Site.create(url: url, user_id: user.id).errors.to_a
  end
end
