class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :response_content
      t.integer :receiver_id
      t.references :user, index: true
      t.references :message, index: true

      t.timestamps
    end
  end
end
