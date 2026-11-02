class AddSideCofFieldsToActivities < ActiveRecord::Migration[8.0]
  def change
    add_column :activities, :number_of_side_cof, :integer
    add_column :activities, :side_cof_number, :string
  end
end
