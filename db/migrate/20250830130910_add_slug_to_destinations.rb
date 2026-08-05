class AddSlugToDestinations < ActiveRecord::Migration[8.0]
  def change
    add_column :destinations, :slug, :string
    add_index :destinations, :slug, unique: true
  end
end
