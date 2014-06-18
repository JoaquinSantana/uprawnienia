class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :nr_roli
      t.string :nazwa
      t.text :opis

      t.timestamps
    end
  end
end
