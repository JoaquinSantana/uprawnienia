class Role < ActiveRecord::Base

	has_many :order_items

	validates :nr_roli, numericality: { only_integer: true, 
		message: "Proszę podać numer" }
	validates :nr_roli, numericality: { greater_than: 0, 
		message: "Numer roli musi być większy od 0" }
			
	validates :nazwa, :opis, presence: true

end
