class CreateMaterialUsages < ActiveRecord::Migration[7.1]
  def change
    create_table :material_usages do |t|
      t.references :job, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.decimal :used_length_m, precision: 10, scale: 2, default: 0
      t.decimal :waste_length_m, precision: 10, scale: 2, default: 0
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :material_usages, :deleted_at
  end
end
