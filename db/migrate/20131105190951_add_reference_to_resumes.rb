class AddReferenceToResumes < ActiveRecord::Migration
  def change
    add_reference :resumes, :user, index: true
  end
end
