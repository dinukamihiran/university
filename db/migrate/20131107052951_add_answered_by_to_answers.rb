class AddAnsweredByToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :answered_by, :integer
  end
end
