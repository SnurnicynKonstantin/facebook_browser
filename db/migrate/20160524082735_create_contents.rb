class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :post
      t.string :media
      t.string :media_type
      t.timestamps null: false
    end
  end
end
