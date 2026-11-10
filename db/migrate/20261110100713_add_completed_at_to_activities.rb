# db/migrate/XXXX_add_completed_at_to_activities.rb
class AddCompletedAtToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :completed_at, :datetime
    add_index :activities, :completed_at

    # Update existing records
    Activity.where(status: %w[completed delivered]).where(completed_at: nil).find_each do |a|
      a.update_column(:completed_at, a.updated_at)
    end
  end
end