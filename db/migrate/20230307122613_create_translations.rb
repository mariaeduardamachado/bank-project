class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :translation_value
      t.string :translation_type
      t.integer :user_id
      t.timestamps
    end
    add_index :translations, :user_id
  end
end
