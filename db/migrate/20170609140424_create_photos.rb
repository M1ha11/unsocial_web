class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :image
      t.string :name
      t.text :description
      t.references :album, foreign_key: true

      t.timestamps
    end
    add_index :photos, [:album_id, :created_at]
  end
end
