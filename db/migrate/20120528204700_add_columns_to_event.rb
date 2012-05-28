class AddColumnsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :min_ticket_price, :int

    add_column :events, :tickets_left, :int

  end
end
