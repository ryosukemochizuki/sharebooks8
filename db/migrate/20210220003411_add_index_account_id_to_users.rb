class AddIndexAccountIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:account_id], unique: true
  end
end
