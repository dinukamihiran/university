class RemoveAskedByFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :asked_by, :integer
  end
end
