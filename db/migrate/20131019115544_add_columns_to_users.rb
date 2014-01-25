class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :batch, :integer
    add_column :users, :degree, :string
  end
end
