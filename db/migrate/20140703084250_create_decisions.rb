class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.integer :order_id
      t.boolean :opinia

      t.timestamps
    end
  end
end
