class AddDetailsToCoffeeRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :coffee_records, :bean_type, :string
    add_column :coffee_records, :process_method, :string
    add_column :coffee_records, :acidity_level, :string
    add_column :coffee_records, :body_level, :string
    add_column :coffee_records, :notes, :text
  end
end
