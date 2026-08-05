class AddSlugToSafaris < ActiveRecord::Migration[8.0]
  def change
    add_column :safaris, :slug, :string
    add_index :safaris, :slug, unique: true
  end
end
