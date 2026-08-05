class CreateDestinations < ActiveRecord::Migration[8.0]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :country
      t.text :description
      t.boolean :featured

      t.timestamps
    end
  end
end
