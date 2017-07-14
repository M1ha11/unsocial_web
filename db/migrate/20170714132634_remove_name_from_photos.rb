class RemoveNameFromPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :name, :string
  end
end
