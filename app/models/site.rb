require 'open-uri'
require 'nkf'
class Site < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :url
  validates_format_of :url, with: URI.regexp, message: 'が不正な形式です。'
  validates_presence_of :user_id

  def image_url
    "http://capture.heartrails.com/400x500/cool?#{url}"
  end
  def thumnail
    "http://capture.heartrails.com/300x300/cool?#{url}"
  end

  def generate_title
    url.gsub!(Regexp.new("[^#{URI::PATTERN::ALNUM}\/\:\?\=&~,\.\(\)#]")) {|match| ERB::Util.url_encode(match)}
    read_data = ::NKF.nkf("--utf8", open(url).read)
    self.title = ::Nokogiri::HTML.parse(read_data, nil, 'utf8').xpath('//title').text
  end
end
