class AddDaneOsoboweToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :dane_osobowe, :boolean, default: false
  end
end
