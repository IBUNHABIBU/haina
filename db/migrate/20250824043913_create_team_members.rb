class CreateTeamMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :title
      t.text :bio
      t.integer :display_order

      t.timestamps
    end
  end
end
