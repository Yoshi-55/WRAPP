class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :maker, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :vehicle_name
      t.string :vehicle_model
      t.string :vehicle_number
      t.string :job_serial
      t.text :description
      t.string :status, null: false, default: "draft"
      t.datetime :started_at
      t.datetime :completed_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :jobs, :job_serial, unique: true
    add_index :jobs, :status
    add_index :jobs, :started_at
    add_index :jobs, :completed_at
    add_index :jobs, :deleted_at
  end
end
