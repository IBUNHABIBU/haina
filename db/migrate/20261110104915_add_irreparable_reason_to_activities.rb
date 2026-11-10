# db/migrate/XXXX_add_irreparable_reason_to_activities.rb
class AddIrreparableReasonToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :irreparable_reason, :string
  end
end