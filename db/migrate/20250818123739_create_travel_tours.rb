class CreateTravelTours < ActiveRecord::Migration[8.0]
  def change
    create_table :travel_tours do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :duration
      t.string :category
      t.boolean :featured
      t.text :highlights
      t.text :includes

      t.timestamps
    end
  end
end
