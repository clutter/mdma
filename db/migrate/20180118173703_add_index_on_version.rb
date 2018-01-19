class AddIndexOnVersion < ActiveRecord::Migration[5.2]
  def change
    add_index :devices, :app_version
  end
end