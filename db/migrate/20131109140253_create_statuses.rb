class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :status_content
      t.references :user, index: true

      t.timestamps
    end
  end
end
