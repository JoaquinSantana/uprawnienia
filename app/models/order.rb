class Order < ActiveRecord::Base
	default_scope { order('created_at DESC') }
	scope :nowe, -> { where(status: 1)} #Zaakceptepowane przez wnioskującego
	scope :potw, -> { where(status: 2)} #Zaakceptowane przez Koordynator
	scope :abii, -> { where(status: 4)} #Zaakceptowane przez ABI
	scope :dane_osob, -> { where(status: 2, dane_osobowe: true)}
	scope :upr_lok, -> { where(uprlok: true) }
	scope :upr_glowne, -> { where(uprlok: false) }

	has_one :decision
	
	has_many :order_items, dependent: :destroy
	has_many :products, through: :order_items
	has_many :branches, through: :users

	has_and_belongs_to_many :users
	has_and_belongs_to_many :contributors, class_name: 'User'


	enum status: [
								:niezatwierdzony, #Status wniosku zainicjowanego
					 			:wobiegu, 				#Status wniosku wysłanego do akceptacji
					 			:potwierdzony, 		#Status wniosku potwierdzonego przez Koordynatora
					 			:kordpopr, 				#Status wniosku wystawionego do poprawy przez Koordynatora
					 			:abipotwierdzam,	#Status wniosku potwierdzonego przez ABI
					 			:odrzucony,				#Status wniosku odrzuconego
					 			:lokpotwierdzam,	#Status wniosku potwierdzonego przez Lokalnego Właściciela Danych
					 			:dyrpotwierdzam		#Status wniosku potwierdzonego przez Dyrektora
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

	def lok_potwierdzam
		self.lokpotwierdzam! if status == "abipotwierdzam" || status == "potwierdzony"
	end

	def dyr_potwierdzam
		self.dyrpotwierdzam! if status == "abipotwierdzam" || status == "potwierdzony"
	end

	def brak_zgody
		self.odrzucony!
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
		elsif status == "lokpotwierdzam"
			return "Potwierdzony przez LOK ADM"
		elsif status == "dyrpotwierdzam"
			return "Potwierdzony przez Dyrektora"
		end
	end

	def oddzial_wnioskujacego
		unless users.blank?
			users.first.branch.nazwa
		end
	end

	def upr_lok?
		self.uprlok == true
	end

	def dane_osobowe?
		self.dane_osobowe == true
	end

end
