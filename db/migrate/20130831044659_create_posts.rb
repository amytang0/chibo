class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.text :adtext
      t.integer :user_id

      t.timestamps
    end
  end
end
