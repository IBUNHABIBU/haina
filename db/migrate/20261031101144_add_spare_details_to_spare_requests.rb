class AddSpareDetailsToSpareRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :spare_requests, :spare_type, :string
    add_column :spare_requests, :requested_part_number, :string
    change_column_null :spare_requests, :spare_id, true
  end
end
