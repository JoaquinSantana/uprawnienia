class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :nazwa

      t.timestamps
    end
  end
end
