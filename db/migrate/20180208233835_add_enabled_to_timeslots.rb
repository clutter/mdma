class AddEnabledToTimeslots < ActiveRecord::Migration[5.2]
  def change
    add_column :timeslots, :enabled, :boolean, default: true, null: false
  end
end
