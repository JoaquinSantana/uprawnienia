class AddWnioskujacyToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :wnioskujacy, :string
  end
end
