class RemoveReceiverIdFromReplies < ActiveRecord::Migration
  def change
    remove_column :replies, :receiver_id, :integer
  end
end
