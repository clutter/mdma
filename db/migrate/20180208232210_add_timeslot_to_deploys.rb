class AddTimeslotToDeploys < ActiveRecord::Migration[5.2]
  def change
    change_table :deploys do |t|
      t.references :timeslot, foreign_key: true
    end
  end
end
