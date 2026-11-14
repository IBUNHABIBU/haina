class AddDeliveredAtToActivities < ActiveRecord::Migration[8.0]
  def change
    add_column :activities, :delivered_at, :datetime
  end
end
