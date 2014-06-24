class Order < ActiveRecord::Base
	has_many :order_items, dependent: :destroy
	belongs_to :user
	has_many :workers


	enum status: [:niezatwierdzony, :wobiegu, :prawidlowy]


	def akcept
		self.wobiegu! if status == "niezatwierdzony" 
	end
end
