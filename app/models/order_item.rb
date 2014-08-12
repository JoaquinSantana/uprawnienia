class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
  has_and_belongs_to_many :branches
  
	validates :product_id, :uniqueness => { :scope => :order_id, :message => "Wnioskujesz już o tą role" }
end
