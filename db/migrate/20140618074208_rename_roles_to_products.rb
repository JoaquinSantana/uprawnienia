class RenameRolesToProducts < ActiveRecord::Migration
  def change
  	rename_table :roles, :products
  end
end
