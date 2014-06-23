class Branch < ActiveRecord::Base
	validate :nazwa, presence: true
	has_many :users


	def to_s
		nazwa
	end
end
