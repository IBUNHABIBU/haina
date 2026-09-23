class CreateTvSizes < ActiveRecord::Migration[8.0]
  def change
    create_table :tv_sizes do |t|
      t.decimal :size

      t.timestamps
    end
  end
end
