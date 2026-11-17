class AddDetailsToTvPanels < ActiveRecord::Migration[8.0]
  def change
    add_column :tv_panels, :remarks, :text
  end
end
