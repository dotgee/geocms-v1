# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dotgee = Account.find_or_create_by_subdomain!(name: "Dotgee", subdomain: "dotgee")
User.destroy_all
User.create!(username: "jerome.chapron", email: "jchapron@dotgee.fr", password: "helloworld", account: dotgee )
