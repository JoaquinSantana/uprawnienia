class AddDaneOsoboweToProducts < ActiveRecord::Migration
  def change
    add_column :products, :dane_osobowe, :boolean, :default => false
  end
end
