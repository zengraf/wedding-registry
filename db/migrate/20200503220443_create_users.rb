class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :phone_number
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
