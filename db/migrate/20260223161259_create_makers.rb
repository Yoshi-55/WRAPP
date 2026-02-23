class CreateMakers < ActiveRecord::Migration[7.1]
  def change
    create_table :makers do |t|
      t.string :name, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :makers, :name
    add_index :makers, :deleted_at
  end
end
