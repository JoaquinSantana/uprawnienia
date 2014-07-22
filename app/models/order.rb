class Order < ActiveRecord::Base
	default_scope { order('created_at DESC') }
	scope :nowe, -> { where(status: 1)} #Zaakceptepowane przez wnioskującego
	scope :potw, -> { where(status: 2)} #Zaakceptowane przez Koordynator
	scope :abii, -> { where(status: 4)} #Zaakceptowane przez ABI
	scope :dane_osob, -> { where(dane_osobowe: true)}

	has_one :decision
	
	has_many :order_items, dependent: :destroy
	has_many :products, through: :order_items

	has_and_belongs_to_many :users
	has_and_belongs_to_many :contributors, class_name: 'User'


	enum status: [
								:niezatwierdzony, #Status wniosku zainicjowanego
					 			:wobiegu, 				#Status wniosku wysłanego do akceptacji
					 			:potwierdzony, 		#Status wniosku potwierdzonego przez Koordynatora
					 			:kordpopr, 				#Status wniosku wystawionego do poprawy przez Koordynatora
					 			:abipotwierdzam,	#Status wniosku potwierdzonego przez ABI
					 			:odrzucony				#Status wniosku odrzuconego
					 											]


	def akcept
		self.wobiegu! if status == "niezatwierdzony" 
	end

	def potwierdzam
		self.potwierdzony! if status == "wobiegu"
	end

	def abi_potwierdzam
		self.abipotwierdzam! if status == "potwierdzony"
	end

	def brak_zgody
		self.odrzucam!
	end

	def sprawdz_status
		if status == "niezatwierdzony"
			return "Niezatwierdzony"
		elsif status == "wobiegu"
			return "W obiegu"
		elsif status == "potwierdzony"
			return "Potwierdzony przez Koordynatora"
		elsif status == "kordpopr"
			return "Do poprawy"
		elsif status == "abipotwierdzam"
			return "Potwierdzony przez ABI"
		elsif status == "odrzucony"
			return "Wniosek odrzucony"
		end
	end

	def oddzial_wnioskujacego
		users.first.branch.nazwa
	end

end
