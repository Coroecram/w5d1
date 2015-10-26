class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :private, default: true
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
    add_foreign_key :goals, :users, column: :user_id
  end
end
