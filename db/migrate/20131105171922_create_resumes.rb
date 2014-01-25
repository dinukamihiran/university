class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :level
      t.string :semester
      t.string :name
      t.string :subject_name
      t.string :attachment
      t.string :added_by

      t.timestamps
    end
  end
end
