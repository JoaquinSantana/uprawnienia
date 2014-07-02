class AddKordkomToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :kordkom, :text, default: nil
  end
end
