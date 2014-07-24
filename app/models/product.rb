class Product < ActiveRecord::Base

	has_many :order_items
	has_and_belongs_to_many :users

	validates :nr_roli, numericality: { only_integer: true, 
		message: "Proszę podać numer" }
	validates :nr_roli, numericality: { greater_than: 0, 
		message: "Numer roli musi być większy od 0" }
			
	validates :nazwa, :opis, presence: true


	def do
		"Przetwarza dane osobowe" if self.dane_osobowe == true
	end

	def dane_osob
		dane_os? ? "TAK" : "NIE"
	end

	def dane_os?
		self.dane_osobowe == true
	end

end
