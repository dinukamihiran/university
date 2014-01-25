class RemoveAddedByFromResumes < ActiveRecord::Migration
  def change
    remove_column :resumes, :added_by, :string
  end
end
