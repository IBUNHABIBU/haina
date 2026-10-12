class AddTechnicalInformationToActivities < ActiveRecord::Migration[8.0]
  def change
    add_column :activities, :board_number, :string
    add_column :activities, :tcon_number, :string
    add_column :activities, :cof_number, :string
    add_column :activities, :panel_number, :string
  end
end
