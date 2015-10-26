class AddAuthorToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    change_column :comments, :user_id, :integer, null: false
    add_index :comments, :user_id
  end
end
