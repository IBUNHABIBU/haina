class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :customer
      t.string :phone
      t.string :TV_brand
      t.integer :TV_size
      t.integer :model_no
      t.datetime :date_in
      t.datetime :date_out
      t.decimal :starting_price
      t.decimal :final_price
      t.integer :status
      t.integer :spare_used
      t.decimal :cost_each
      t.decimal :total_cost
      t.decimal :profit
      t.text :remarks
      t.decimal :labour_cost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
