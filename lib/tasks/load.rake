# Es psoble llenar la base de datos utilizando task que corren con el comando rake namespece:task
namespace :db do
	desc "Cargar datos a tabla customers"
	task populate_customers: :environment  do
		Customer.destroy_all # Elimina los datos de la tabla customer		
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
	end
end