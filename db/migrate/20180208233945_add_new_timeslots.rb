class AddNewTimeslots < ActiveRecord::Migration[5.2]
  def up
    Timeslot.update_all enabled: false
    Timeslot.create! delay_in_hours: 0, prefixes: %i[NY CHI HQ]
    Timeslot.create! delay_in_hours: 8, prefixes: %i[LA SE SF ONT OC SD]
  end

  def down
    Timeslot.where(prefixes: %i[NY CHI HQ]).destroy_all
    Timeslot.where(prefixes: %i[LA SE SF ONT OC SD]).destroy_all
    Timeslot.update_all enabled: true
  end
end
