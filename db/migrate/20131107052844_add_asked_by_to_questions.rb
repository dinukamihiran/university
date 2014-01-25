class AddAskedByToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :asked_by, :integer
  end
end
