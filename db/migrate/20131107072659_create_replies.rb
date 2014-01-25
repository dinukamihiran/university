class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :reply_content
      t.references :answer, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
