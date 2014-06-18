class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :role_id
      t.integer :order_id

      t.timestamps
    end
  end
end
