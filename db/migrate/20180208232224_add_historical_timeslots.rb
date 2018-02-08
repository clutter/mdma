class AddHistoricalTimeslots < ActiveRecord::Migration[5.2]
  def up
    timeslot = Timeslot.create! prefixes: [], delay_in_hours: 0
    Deploy.update_all timeslot_id: timeslot.id
  end

  def down
    Timeslot.destroy_all
  end
end
