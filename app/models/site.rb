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
end
