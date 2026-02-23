class CreateWorkLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :work_logs do |t|
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.integer :duration_minutes
      t.text :note
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :work_logs, :started_at
    add_index :work_logs, :ended_at
    add_index :work_logs, :deleted_at
  end
end
