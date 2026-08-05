class CreateTestimonials < ActiveRecord::Migration[8.0]
  def change
    create_table :testimonials do |t|
      t.string :author_name
      t.string :author_title
      t.text :content
      t.integer :rating

      t.timestamps
    end
  end
end
