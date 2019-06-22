namespace :utils do

  desc "Cria Administadores Fake"

  task generate_admins: :environment do

  	puts "Cadastrando os Administadores..."

  	100.times do
  		User.create!(email: Faker::Internet.email,
  					password: "123456",
  					password_confirmation: "123456")
  	end

  	puts "Administadores cadastrados com sucesso!"

  end

end
