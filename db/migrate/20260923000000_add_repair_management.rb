class AddRepairManagement < ActiveRecord::Migration[8.0]
  def change
    create_table :spare_categories do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.timestamps
    end
    add_index :spare_categories, :code, unique: true

    create_table :spares do |t|
      t.references :spare_category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :part_number
      t.string :brand
      t.decimal :unit_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :selling_price, precision: 15, scale: 2, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.integer :reorder_level, null: false, default: 0
      t.string :location
      t.text :notes
      t.timestamps
    end
    add_index :spares, :part_number

    create_table :activity_spares do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :spare, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.decimal :unit_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :total_cost, precision: 15, scale: 2, null: false, default: 0
      t.timestamps
    end
    add_index :activity_spares, [:activity_id, :spare_id], unique: true

    create_table :repair_returns do |t|
      t.references :activity, null: false, foreign_key: true
      t.integer :return_number, null: false
      t.datetime :returned_at, null: false
      t.string :location, null: false
      t.string :reason, null: false
      t.string :condition
      t.string :status, null: false, default: "received"
      t.text :notes
      t.timestamps
    end
    add_index :repair_returns, [:activity_id, :return_number], unique: true

    create_table :expenses do |t|
      t.string :category, null: false
      t.string :description, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false, default: 0
      t.date :spent_on, null: false
      t.string :reference
      t.text :notes
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :expenses, :spent_on
    add_index :expenses, :category

    add_reference :activities, :customer, foreign_key: true
    add_reference :activities, :tv_brand, foreign_key: true
    add_reference :activities, :tv_size, foreign_key: true
    add_reference :activities, :tatizo, foreign_key: true
    add_column :activities, :price, :decimal, precision: 15, scale: 2, null: false, default: 0
    add_column :activities, :labour_charge, :decimal, precision: 15, scale: 2, null: false, default: 0
    add_column :activities, :gross_profit, :decimal, precision: 15, scale: 2, null: false, default: 0
    add_column :activities, :returned_count, :integer, null: false, default: 0

    add_index :activities, :date_in
    add_index :activities, :status

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE activities
          SET customer_id = customers.id
          FROM customers
          WHERE activities.customer_id IS NULL
            AND activities.customer IS NOT NULL
            AND customers.name = activities.customer
        SQL

        execute <<~SQL
          UPDATE activities
          SET tv_brand_id = tv_brands.id
          FROM tv_brands
          WHERE activities.tv_brand_id IS NULL
            AND activities."TV_brand" IS NOT NULL
            AND tv_brands.name = activities."TV_brand"
        SQL

        execute <<~SQL
          UPDATE activities
          SET tv_size_id = tv_sizes.id
          FROM tv_sizes
          WHERE activities.tv_size_id IS NULL
            AND activities."TV_size" IS NOT NULL
            AND tv_sizes.size = activities."TV_size"
        SQL

        execute <<~SQL
          UPDATE activities
          SET price = COALESCE(final_price, starting_price, 0),
              labour_charge = COALESCE(labour_cost, 0),
              gross_profit = COALESCE(profit, 0)
        SQL
      end
    end

    create_table :spare_purchases do |t|
      t.references :spare, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :unit_cost, precision: 15, scale: 2, null: false
      t.decimal :total_cost, precision: 15, scale: 2, null: false
      t.string :supplier
      t.date :purchased_on, null: false
      t.string :reference
      t.text :notes
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :spare_purchases, :purchased_on
  end
end
