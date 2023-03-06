class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :integer
    add_column :users, :cpf, :integer
    add_column :users, :rg, :integer
    add_column :users, :road, :string
    add_column :users, :neighborhood, :string
    add_column :users, :number, :string
    add_column :users, :complement, :string
    add_column :users, :active, :boolean
    add_column :users, :cep, :integer
    add_column :users, :income, :string
    add_column :users, :patrimony, :string
    add_column :users, :agency, :integer
    add_column :users, :account, :integer
  end
end
