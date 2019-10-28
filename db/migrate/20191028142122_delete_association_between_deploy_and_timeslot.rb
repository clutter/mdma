class DeleteAssociationBetweenDeployAndTimeslot < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :deploys, :timeslots
    remove_index :deploys, :timeslot_id
    remove_column :deploys, :timeslot_id, :bigint
  end
end
