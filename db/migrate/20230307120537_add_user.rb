class AddUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sex, :string
    add_column :users, :encrypted_password_card, :string, null: false, default: ""
    add_column :users, :reset_password_card_token, :string 
    add_column :users, :reset_password_card_sent_at, :datetime
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :balance, :integer
  end
end
