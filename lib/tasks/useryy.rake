namespace :db do 
	desc "Przykładowi pracownicy"
	task populate: :environment do
		#dodaj_uzyt Dodawanie użytkowników
		dodaj_produkt #dodanie produktów (ról)
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


def dodaj_produkt
	Product.create(nr_roli: 1222, nazwa: 'KLM', opis: "Tworzenie planu zapotrzebowań")
	Product.create(nr_roli: 134, nazwa: 'KKW', opis: "Potwierdzanie zamówień", dane_osobowe: true)
	Product.create(nr_roli: 4324, nazwa: 'SDR', opis: "Edycja pracowników SDR", dane_osobowe: true)
	Product.create(nr_roli: 561, nazwa: 'LZAM', opis: "Waga towarowa - obsługa")
	Product.create(nr_roli: 8346, nazwa: 'SOP', opis: "Przegląd na produkcji", dane_osobowe: true)
end


