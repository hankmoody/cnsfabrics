# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Fabric.delete_all
User.delete_all

fabric_array = []
for i in 0..40
  fabric_array.push({
    code: "Cns #{i+100}",
    width: rand(20..100),
    quantity: rand(500..10000),
    image: URI.parse("http://placehold.it/#{rand(600..1000)}x#{rand(500..900)}.png")
  })
end

Fabric.create!(fabric_array)
User.create!(:email => "ashishgupta13@gmail.com",
             :password => "admin1234",
             :admin => true)
