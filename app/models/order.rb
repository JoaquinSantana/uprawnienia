class Order < ActiveRecord::Base
	default_scope { order('created_at DESC') }

	has_many :order_items, dependent: :destroy
	belongs_to :user
	has_and_belongs_to_many :contributors, class_name: 'User'
	has_many :workers


	enum status: [:niezatwierdzony, :wobiegu, :prawidlowy]


	def akcept
		self.wobiegu! if status == "niezatwierdzony" 
	end
end
