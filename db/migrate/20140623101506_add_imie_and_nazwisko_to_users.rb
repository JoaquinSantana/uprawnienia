class AddImieAndNazwiskoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :imie, :string
  	add_column :users, :nazwisko, :string
  end
end
