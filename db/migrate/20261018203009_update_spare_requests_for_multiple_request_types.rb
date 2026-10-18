
class UpdateSpareRequestsForMultipleRequestTypes < ActiveRecord::Migration[8.0]
  def up
    change_column_null :spare_requests, :activity_id, true

    add_column :spare_requests, :request_type, :string,
               null: false, default: "activity"

    add_index :spare_requests, :request_type
  end

  def down
    remove_index :spare_requests, :request_type
    remove_column :spare_requests, :request_type
    change_column_null :spare_requests, :activity_id, false
  end
end
