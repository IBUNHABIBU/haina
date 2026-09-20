class CreateRepairJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :repair_jobs do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tv_brand, null: false, foreign_key: true
      t.references :tv_size, null: false, foreign_key: true
      t.decimal :labour_price
      t.decimal :total_sale
      t.integer :status
      t.string :tatizo
      t.string :reference
      t.string :motherboard_number
      t.string :tcon_number
      t.string :panel_number
      t.string :cof_number

      t.timestamps
    end
  end
end
