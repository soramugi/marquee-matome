# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
users = User.create(
  [
    {
      name: 'huge',
      provider: 'twitter',
      uid: 12345678,
    },
    {
      name: 'foge',
      provider: 'twitter',
      uid: 87654321,
    },
  ]
)
Site.delete_all
Site.create(
  [
    {
      url: 'http://homucifer.info/harasu/',
      title: 'はらすAAまとめ',
      user_id: users.sample.id,
    },
    {
      url: 'http://hitode909.appspot.com/speed_reading/',
      title: '速読ウェブサービス',
      user_id: users.sample.id,
    },
    {
      url: 'http://hitode909.hatenablog.com/entry/2014/03/17/201717',
      title: 'marquee - hitode909の日記',
      user_id: users.sample.id,
    },
  ]
)
