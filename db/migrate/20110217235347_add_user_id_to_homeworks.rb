class AddUserIdToHomeworks < ActiveRecord::Migration
  def self.up
    add_column :homeworks, :user_id, :integer
    add_index :homeworks, :user_id
  end

  def self.down
    remove_index :homeworks, :user_id
    remove_column :homeworks, :user_id
  end
end
