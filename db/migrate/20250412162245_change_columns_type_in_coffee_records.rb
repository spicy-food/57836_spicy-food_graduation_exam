class ChangeColumnsTypeInCoffeeRecords < ActiveRecord::Migration[7.1]
  def change
    change_column :coffee_records, :roast_level, :string
    change_column :coffee_records, :acidity_level, :string
    change_column :coffee_records, :body_level, :string
  end
end
