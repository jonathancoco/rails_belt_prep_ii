class UpdateCommentTable < ActiveRecord::Migration
  def change
    add_column :comments, :comment, :string
  end
end
