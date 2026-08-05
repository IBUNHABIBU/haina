class AddSlugToTrekkings < ActiveRecord::Migration[8.0]
  def change
    add_column :trekkings, :slug, :string
    add_index :trekkings, :slug, unique: true
  end
end
