require 'open-uri'
require 'nkf'
class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # friendly_id の日本語対応
  def normalize_friendly_id(string)
    string.gsub(/[\.\s]/, "-")
  end

  belongs_to :user

  validates_presence_of :url
  validates_format_of :url, with: URI.regexp, message: 'が不正な形式です。'
  validates_presence_of :user_id

  validate do
    if Site.find_by(url: url).present?
      errors.add(:url, 'が重複しています')
    end
  end

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

  def generate_gif
    dir = 'tmp/pict'
    `phantomjs #{Rails.root.join('bin/pict.js')} '#{url}' '#{Rails.root.join(dir)}'`
    images = Dir.glob(Rails.root.join(dir, '*'))
    rmagick = ::Magick::ImageList.new(*images)
    rmagick.iterations = 0
    rmagick.each {|i| i.delay = 5 }
    File.delete(*images)
    rmagick.write(Rails.root.join('animation.gif'))
    rmagick
  end

end
