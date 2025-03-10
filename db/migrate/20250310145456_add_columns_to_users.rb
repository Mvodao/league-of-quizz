class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :ranking, :integer
    add_reference :users, :avatar, null: false, foreign_key: true
  end
end
