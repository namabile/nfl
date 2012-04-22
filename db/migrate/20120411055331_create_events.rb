class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_id
      t.string :name
      t.string :city
      t.string :state
      t.integer :state_id
      t.string :venue
      t.integer :venue_id
      t.datetime :date
      t.string :map_url
      t.timestamps
    end
  end
end
