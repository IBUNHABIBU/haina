class AddNumberOfCofToActivities < ActiveRecord::Migration[8.0]
  def change
    add_column :activities, :number_of_cof, :integer
  end
end
