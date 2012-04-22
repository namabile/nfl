class CreateTicketSplits < ActiveRecord::Migration
  def change
    create_table :ticket_splits do |t|
      t.integer :ticket_id
      t.integer :split
      t.timestamps
    end
    add_index :ticket_splits, :ticket_id
  end
end
