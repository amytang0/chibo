class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.text :adtext
      t.integer :numberofpeople, :default => 0
      t.decimal :budget, :default => 0.0
      t.decimal :costOfFifteen, :default => 0.00
      t.decimal :costOfThirty, :default => 0.00
      t.decimal :costOfFifty, :default => 0.00
      t.decimal :costOverFifty, :default => 0.00
      t.integer :user_id
      t.boolean :showBudget, :default => false

      t.timestamps
    end
  end

end

