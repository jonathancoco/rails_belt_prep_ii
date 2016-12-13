class UpdateLikeTable < ActiveRecord::Migration
  def change
    rename_column :likes, :likeable, :likeable_type
  end
end
