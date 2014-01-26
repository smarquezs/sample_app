# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Es posible tambien realizar el poblado de datos utilizando seed, el cual se ejecuta mediante
# rake db:seed

Customer.destroy_all #Elinina los datos de la tabla customers

150.times do |i|
	code = Faker::Code.isbn
	name = Faker::Name.name
	address = "#{Faker::Address.street_name} #{Faker::Address.building_number}"
	email = Faker::Internet.email
	name = Faker::Name.name
	company = Faker::Company.name
	description = Faker::Lorem.sentence
	city = Faker::Address.city

	Customer.create(code: code, name: name, address: address, email: email, company: company, description: description, city: city)
end