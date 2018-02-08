class CreateTimeslots < ActiveRecord::Migration[5.2]
  def change
    create_table :timeslots do |t|
      t.text :prefixes, array: true, null: false
      t.integer :delay_in_hours, null: false, index: true
    end
  end
end
