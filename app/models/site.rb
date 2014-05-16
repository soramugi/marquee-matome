require 'open-uri'
require 'nkf'
class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # friendly_id の日本語対応
  def normalize_friendly_id(string)
    string.gsub(/[\.\s]/, "-")
  end

  has_attached_file :capture, styles: { thumnail: '300x300#' }
  validates_attachment_content_type :capture, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  validates_presence_of :url
  validates_format_of :url, with: URI.regexp, message: 'が不正な形式です。'
  validates_presence_of :user_id

  validate do
    # TODO marqueeタグが使われてるサイトか確認
    if new_record? && Site.find_by(url: url).present?
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
    images = local_generate_captures
    rmagick = ::Magick::ImageList.new(*images)
    File.delete(*images)
    rmagick.iterations = 0
    rmagick.each {|i| i.delay = 5 }
    tempfile = Tempfile.new(['animation', '.gif'])
    rmagick.write(tempfile.path)
    update_attributes!(capture: File.new(tempfile.path))
    tempfile.close!
  end

  private
  def local_generate_captures dir = 'tmp/pict'
    `phantomjs #{Rails.root.join('bin/pict.js')} '#{url}' '#{Rails.root.join(dir)}'`.split(/[\r\n]/)
  end
end
