class ReplaceHallEnumWithRelationInOrders < ActiveRecord::Migration[6.0]
  def up
    add_reference :orders, :hall, null: true

    execute <<-SQL
      UPDATE orders
      SET hall_id = (SELECT id FROM halls WHERE name = 'Mała')
      WHERE hall = 0
    SQL

    execute <<-SQL
      UPDATE orders
      SET hall_id = (SELECT id FROM halls WHERE name = 'Duża')
      WHERE hall = 1
    SQL

    change_column_null :orders, :hall_id, false
    remove_column :orders, :hall
  end

  def down
    add_column :orders, :hall, :integer

    execute <<-SQL
      UPDATE orders
      SET hall = 0
      WHERE EXISTS (SELECT id
                    FROM halls
                    WHERE name = 'Mała' AND id = orders.hall_id)
    SQL

    execute <<-SQL
      UPDATE orders
      SET hall = 1
      WHERE EXISTS (SELECT id
                    FROM halls
                    WHERE name = 'Duża' AND id = orders.hall_id)
    SQL
  end
end
