class Site < ActiveRecord::Base
  def thumnail
    "http://capture.heartrails.com/300x300/cool?#{url}"
  end
end
