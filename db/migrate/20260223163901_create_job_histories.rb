class CreateJobHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :job_histories do |t|
      t.references :job, null: false, foreign_key: true
      t.string :action_type, null: false
      t.text :note
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :job_histories, :action_type
    add_index :job_histories, :created_at
    add_index :job_histories, :deleted_at
  end
end
