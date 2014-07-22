class Branch < ActiveRecord::Base
  has_many :users
  has_many :orders, :through => :users
  has_and_belongs_to_many :order_items
	
  validate :nazwa, presence: true

	def to_s
		nazwa
	end
end
