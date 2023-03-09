class AddUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sex, :string
    add_column :users, :password_card, :string, null: false, default: ""
    add_column :users, :city, :string
    add_column :users, :balance, :string
    add_column :users, :state, :string
  end
end
