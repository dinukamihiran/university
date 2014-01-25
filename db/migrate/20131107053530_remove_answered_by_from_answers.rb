class RemoveAnsweredByFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :answered_by, :integer
  end
end
