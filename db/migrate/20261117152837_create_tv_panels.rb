class CreateTvPanels < ActiveRecord::Migration[8.0]
   def change
    create_table :tv_panels do |t|
      t.references :tv_brand, null: false, foreign_key: true
      t.references :tv_size, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      
      t.decimal :buy_price, precision: 12, scale: 2, default: 0.0
      t.decimal :sell_price, precision: 12, scale: 2, default: 0.0
      t.string :status, default: "in_stock" # in_stock, sold
      t.datetime :sold_at
      
      t.timestamps
    end
  end
end
