# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.where(
  provider:  'twitter',
  uid:       '68404422',
  name:      'soramugi',
  image_url: 'http://pbs.twimg.com/profile_images/2863509226/5ebf54d483f89f1811fc0faa57acdcbe_normal.jpeg',
).first_or_create

relation = Site.where(user_id: user.id)
relation.where(
  title: '速読ウェブサービス',
  url: 'http://hitode909.appspot.com/speed_reading/',
).first_or_create
relation.where(
  title: 'marquee - hitode909の日記',
  url: 'http://hitode909.hatenablog.com/entry/2014/03/17/201717',
).first_or_create
relation.where(
  title: '萌えらんくBEST100',
  url: 'http://moe100.com/html/index.php',
).first_or_create
