class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :role
	validates_uniqueness_of :role_id, :scope => :order_id, :message => "Wnioskujesz już o tą role"
end
