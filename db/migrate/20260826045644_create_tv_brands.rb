class CreateTvBrands < ActiveRecord::Migration[8.0]
  def change
    create_table :tv_brands do |t|
      t.string :name

      t.timestamps
    end
  end
end
