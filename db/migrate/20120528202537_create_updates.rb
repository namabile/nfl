class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :update_type

      t.timestamps
    end
  end
end
