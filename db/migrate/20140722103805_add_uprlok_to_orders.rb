class AddUprlokToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :uprlok, :boolean, :default => false
  end
end
