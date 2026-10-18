class CreateAllPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :all_prices do |t|
      t.references :tv_size, null: false, foreign_key: true
      t.integer :technician_price
      t.integer :customer_price
      t.string :idadiyacof

      t.timestamps
    end
  end
end
