class User < ActiveRecord::Base
  has_many :sites

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider  = auth['provider']
      user.uid       = auth['uid']
      user.name      = auth['info']['nickname']
      user.image_url = auth['info']['image']
    end
  end

  def url
    "https://twitter.com/#{name}"
  end
end
