class Order < ActiveRecord::Base
	has_many :order_items, dependent: :destroy
	belongs_to :user, inverse_of: :orders
	has_and_belongs_to_many :contributors, class_name: 'User'
	has_many :workers


	enum status: [:niezatwierdzony, :wobiegu, :prawidlowy]


	def akcept
		self.wobiegu! if status == "niezatwierdzony" 
	end
end
