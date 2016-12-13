class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :likeable_id
      t.string :likeable
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
