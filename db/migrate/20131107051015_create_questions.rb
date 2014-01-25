class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question_content
      t.references :subject, index: true

      t.timestamps
    end
  end
end
