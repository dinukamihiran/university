class RemoveSubjectNameFromResumes < ActiveRecord::Migration
  def change
    remove_column :resumes, :subject_name, :string
  end
end
