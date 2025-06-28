class AddImageToCoffeeRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :coffee_records, :image, :string
  end
end
