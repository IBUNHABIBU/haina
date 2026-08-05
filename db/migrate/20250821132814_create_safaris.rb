class CreateSafaris < ActiveRecord::Migration[8.0]
  def change
    create_table :safaris do |t|
      t.string :title
      t.integer :duration
      t.string :difficulty
      t.string :overview_title
      t.text :overview_description
      t.text :main_attractions
      t.string :best_season
      t.decimal :price_per_person
      t.integer :min_people
      t.integer :max_people
      t.string :departure_location
      t.string :return_location
      t.string :accommodation_type
      t.string :transport_type
      t.text :included_services
      t.text :excluded_services
      t.text :what_to_bring
      t.text :daily_activities
      t.text :wildlife_highlight
      t.boolean :is_featured
      t.string :status
      t.text :main_image_alt

      t.timestamps
    end
  end
end
