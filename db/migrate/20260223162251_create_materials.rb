class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.string :name, null: false
      t.string :brand
      t.string :color
      t.integer :width_mm
      t.decimal :unit_price, precision: 10, scale: 2
      t.string :unit, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :materials, :name
    add_index :materials, :brand
    add_index :materials, :deleted_at
  end
end
