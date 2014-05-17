require 'test_helper'

class SitesTest < ActiveSupport::TestCase
  def setup
    @title = 'hugehuge'
    @url = 'http://www.example.com'
    stub_request(:get, @url).to_return(body: "<title>#{@title}</title>")
  end
  test "create" do
    user = users(:one)
    assert_equal [], Site.create(url: @url, user_id: user.id).errors.to_a
    assert_equal ["Url が重複しています"], Site.create(url: @url, user_id: user.id).errors.to_a
  end
  test "generate_title" do
    site = Site.new(url: @url)
    assert site.generate_title
    assert_equal @title, site.title
  end
end
