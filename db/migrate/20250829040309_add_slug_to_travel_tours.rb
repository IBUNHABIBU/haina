class AddSlugToTravelTours < ActiveRecord::Migration[8.0]
  def change
    add_column :travel_tours, :slug, :string
    add_index :travel_tours, :slug, unique: true
  end
end
