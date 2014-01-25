class AddSubjectRefToResumes < ActiveRecord::Migration
  def change
    add_reference :resumes, :subject, index: true
  end
end
