class CreateReturns < ActiveRecord::Migration[8.0]
  def change
    create_table :returns do |t|
      t.references :repair_job, null: false, foreign_key: true
      t.string :reason
      t.text :remarks

      t.timestamps
    end
  end
end
