class CreateInterrelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :interrelationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :interrelationships, :follower_id
    add_index :interrelationships, :followed_id
    add_index :interrelationships, [:follower_id, :followed_id], unique: true
  end
end
