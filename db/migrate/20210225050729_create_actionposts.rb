class CreateActionposts < ActiveRecord::Migration[6.0]
  def change
    create_table :actionposts do |t|
      t.string :title
      t.text :highlight
      t.text :action
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
      add_index :actionposts, [:user_id, :created_at]
  end
end
