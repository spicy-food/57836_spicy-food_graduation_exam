class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject, null: false
      t.text :message, null: false
      t.string :category
      t.boolean :read, default: false
      t.timestamps
    end
    
    add_index :contacts, :email
    add_index :contacts, :read
  end
end