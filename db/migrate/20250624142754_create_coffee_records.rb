class CreateCoffeeRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :coffee_records do |t|
      t.string :name
      t.text :description
      t.string :roast_level
      t.string :origin
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
