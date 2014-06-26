namespace :db do 
	desc "Przykładowi pracownicy"
	task populate: :environment do
		dodaj_uzyt
	end
end

def dodaj_uzyt

	piekadm = User.create!(imie: 'Marian',
		nazwisko: 'Poszla',
		email: 'piekadm@test.com',
		password: 'test1234',
		password_confirmation: 'test1234',
		role: Role.with_name(:kier),
		branch: Branch.where(id: 2).first)
	10.times do |n|
		imie = Faker::Name.first_name
		nazwisko = Faker::Name.last_name
		email = "piek-#{n+1}@test.com"
		User.create!(imie: imie,
			nazwisko: nazwisko,
			email: email,
			role: Role.with_name(:uzyt),
			branch: Branch.where(id: 2).first,
			password: 'test1234',
			password_confirmation: 'test1234')
	end
end



