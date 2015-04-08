class CreateEventDetails < ActiveRecord::Migration
  def change
    create_table :event_details do |t|

      t.integer :event_id

      t.text :information
      t.string :reference

      t.string :other1
      t.string :other2
      t.string :other3
      t.string :other4
      t.string :other5
      t.string :other6

      t.timestamps null: false
    end

    add_index :event_details, :event_id
  end

end
