class AddIndexToPost < ActiveRecord::Migration
  def change
    add_index :posts, :created_time
  end
end
