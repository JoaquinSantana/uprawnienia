class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :nazwa

      t.timestamps
    end
  end
end
