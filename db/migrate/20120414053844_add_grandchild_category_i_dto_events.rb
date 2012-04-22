class AddGrandchildCategoryIDtoEvents < ActiveRecord::Migration
  def up
  	add_column :events, :grandchild_category_id, :integer
  	add_column :teams, :grandchild_category_id, :integer
  	add_index :events, :event_id
  	add_index :teams, :team_id
  	add_index :tickets, :event_id
  	add_index :tickets, :ticket_id
  end
end
