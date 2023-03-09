class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :translation_value
      t.string :translation_type
      t.string :balance
      t.string :password_translation
      t.integer :user_id
      t.integer :transfer_user
      t.integer :transferred_user
      t.timestamps
    end
    add_index :translations, :user_id
  end
end
