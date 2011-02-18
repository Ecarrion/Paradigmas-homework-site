class AddFileToHomeworks < ActiveRecord::Migration
  def self.up
    add_column :homeworks, :file_file_name, :string
    add_column :homeworks, :file_content_type, :string
    add_column :homeworks, :file_file_size, :integer
  end

  def self.down
    remove_column :homeworks, :file_file_size
    remove_column :homeworks, :file_content_type
    remove_column :homeworks, :file_file_name
  end
end
