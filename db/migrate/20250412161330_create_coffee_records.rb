class CreateCoffeeRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :coffee_records do |t|
      t.references :user, null: false, foreign_key: true
      t.string :origin, null: false
      t.string :bean_type, null: false
      t.string :process_method, null: false
      t.integer :roast_level, null: false
      t.integer :acidity_level, null: false
      t.integer :body_level, null: false
      t.text :notes
      t.string :image

      t.timestamps
    end
  end
end
