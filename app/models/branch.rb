class Branch < ActiveRecord::Base
	validate :nazwa, presence: true
	has_many :users
	has_many :orders, through: :users



	def to_s
		nazwa
	end
end
