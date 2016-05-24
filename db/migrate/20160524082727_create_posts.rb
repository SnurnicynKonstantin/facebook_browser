class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :group, index: true
      t.string     :author
      t.string     :message
      t.string     :post_id
      t.datetime   :created_time
      t.timestamps null: false
    end
  end
end
