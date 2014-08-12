class AddAssistansProducts < ActiveRecord::Migration
  def change
    create_table :assistants_products, :id => false do |t|
      t.integer :user_id
      t.integer :product_id
    end
  end
end
