class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.text :adtext
      t.integer :numberofpeople
      t.decimal :budget
      t.decimal :costOfFifteen
      t.decimal :costOfThirty
      t.decimal :costOfFifty
      t.integer :user_id
      t.boolean :showBudget

      t.timestamps
    end
  end
end
