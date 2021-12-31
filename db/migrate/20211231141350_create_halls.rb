class CreateHalls < ActiveRecord::Migration[6.0]
  def up
    create_table :halls do |t|
      t.string :name

      t.timestamps
    end

    execute <<-SQL
      INSERT INTO halls (name, created_at, updated_at) VALUES
      ('Mała', TIME(), TIME()),
      ('Duża', TIME(), TIME())
    SQL
  end

  def down
    drop_table :halls
  end
end
