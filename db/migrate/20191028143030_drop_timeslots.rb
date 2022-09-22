# typed: true

class DropTimeslots < ActiveRecord::Migration[6.0]
  def change
    drop_table :timeslots do |t|
      t.text :prefixes, null: false, array: true
      t.integer :delay_in_hours, null: false
      t.boolean :enabled, default: true, null: false
      t.index ['delay_in_hours'], name: :index_timeslots_on_delay_in_hours
    end
  end
end
