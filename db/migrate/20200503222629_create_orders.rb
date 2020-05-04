class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :surname
      t.string :phone_number
      t.date :date
      t.numeric :deposit
      t.integer :hall_id
      t.boolean :confirmed
      t.references :added_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
