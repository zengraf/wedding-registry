class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :order, null: false, foreign_key: true
      t.text :description
      t.datetime :start_time, null: false
      t.datetime :end_time, null: true
      t.decimal :actual_price, precision: 8, scale: 2, null: true
      t.decimal :price, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
