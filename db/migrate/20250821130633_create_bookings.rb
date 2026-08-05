class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :trek_name
      t.date :start_date
      t.date :end_date
      t.integer :number_of_people
      t.text :special_requests
      t.string :status

      t.timestamps
    end
  end
end
