class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :content
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
  end

  def self.down
    drop_table :comments
  end
end
