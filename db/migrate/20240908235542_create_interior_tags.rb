class CreateInteriorTags < ActiveRecord::Migration[6.1]
  def change
    create_table :interior_tags do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :interior_tags, :name, unique: true
  end
end
