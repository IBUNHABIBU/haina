class CreateTrekkings < ActiveRecord::Migration[8.0]
  def change
    create_table :trekkings do |t|
      t.string :title
      t.integer :duration
      t.string :difficulty
      t.string :overview_title
      t.text :overview_description

      t.timestamps
    end
  end
end
