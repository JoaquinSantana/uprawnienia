class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	validates_uniqueness_of :product_id, :scope => :order_id, :message => "Wnioskujesz już o tą role"
end
