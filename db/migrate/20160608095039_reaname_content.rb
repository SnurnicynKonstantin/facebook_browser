class ReanameContent < ActiveRecord::Migration
  def change
    rename_table :contents, :subattachments
  end
end
