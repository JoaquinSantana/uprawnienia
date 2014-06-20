class ChangeRoleIdToProductId < ActiveRecord::Migration
  def change
  	rename_column :order_items, :role_id, :product_id
  end
end
