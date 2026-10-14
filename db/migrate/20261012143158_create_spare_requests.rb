class CreateSpareRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :spare_requests do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :spare, null: false, foreign_key: true
      t.references :requested_by, null: false, foreign_key: { to_table: :users }
      t.references :issued_by, foreign_key: { to_table: :users }
      t.integer :requested_quantity
      t.integer :issued_quantity, null: false, default: 0
      t.decimal :unit_cost_at_issue, precision: 12, scale: 2
      t.string :status, null: false, default: "requested"
      t.text :reason
      t.text :store_notes
      t.datetime :issued_at

      t.timestamps
    end
  end
end
