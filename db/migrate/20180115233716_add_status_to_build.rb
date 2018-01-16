class AddStatusToBuild < ActiveRecord::Migration[5.2]
  def change
    add_column :builds, :status, :integer, default: 0, null: false
  end
end