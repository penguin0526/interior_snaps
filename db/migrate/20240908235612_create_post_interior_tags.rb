class CreatePostInteriorTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_interior_tags do |t|
      t.references :post, null: false, foreign_key: true
      t.references :interior_tag, null: false, foreign_key: true
      t.timestamps
    end
    add_index :post_interior_tags,[ :post_id, :interior_tag_id], unique: true
  end
end
