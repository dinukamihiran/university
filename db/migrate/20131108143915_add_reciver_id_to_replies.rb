class AddReciverIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :receiver_id, :integer
  end
end
