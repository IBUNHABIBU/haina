class CreateTatizos < ActiveRecord::Migration[8.0]
  def change
    create_table :tatizos do |t|
      t.string :name

      t.timestamps
    end
  end
end
