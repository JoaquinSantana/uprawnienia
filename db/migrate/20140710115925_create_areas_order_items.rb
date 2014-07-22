class CreateAreasOrderItems < ActiveRecord::Migration
  def change
    create_table :areas_order_items, :id => false do |t|
      t.integer :area_id
      t.integer :order_item_id
    end
  end
end
