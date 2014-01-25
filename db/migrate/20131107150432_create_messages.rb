class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message_content
      t.integer :receiver_id  
      t.references :user, index: true

      t.timestamps
    end
	
  end
end
