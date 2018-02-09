class RemoveStatusFromBuild < ActiveRecord::Migration[5.2]
  def change
    remove_column :builds, :status, :integer, default: 0, null: false
  end
end
