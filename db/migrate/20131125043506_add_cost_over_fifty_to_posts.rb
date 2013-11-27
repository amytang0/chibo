class AddCostOverFiftyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :costOverFifty, :decimal
  end
end
