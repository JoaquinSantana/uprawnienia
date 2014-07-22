class BranchesOrderItems < ActiveRecord::Migration
  def change
      create_table "branches_order_items", id: false do |t|
      t.integer "branch_id"
      t.integer "order_item_id"
    end
  end
end
