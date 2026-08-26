class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :mahali

      t.timestamps
    end
  end
end
