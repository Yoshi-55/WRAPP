class CreateJobPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :job_photos do |t|
      t.references :job, null: false, foreign_key: true
      t.string :image_url
      t.string :photo_type, null: false, default: "during"
      t.text :note
      t.integer :sort_order, default: 0
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :job_photos, :photo_type
    add_index :job_photos, :sort_order
    add_index :job_photos, :deleted_at
  end
end
