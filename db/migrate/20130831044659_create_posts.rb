class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.text :adtext
      t.integer :numberofpeople, :default => 0
      t.decimal :budge, :default => 0.0
      t.decimal :costOfFifteen, :default => -1.0
      t.decimal :costOfThirty, :default => -1.0
      t.decimal :costOfFifty, :default => -1.0
      t.integer :user_id
      t.boolean :showBudget, :default => false

      t.timestamps
    end
  end

end

