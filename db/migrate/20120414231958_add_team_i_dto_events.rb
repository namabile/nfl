class AddTeamIDtoEvents < ActiveRecord::Migration
  def up
  	add_column :events, :team_id, :integer
  	add_index :events, :team_id
  end

  def down
  	remove_column :events, :team_id, :integer
  	remove_index :events, :team_id
  end
end
