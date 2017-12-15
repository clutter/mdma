class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.integer :app_version

      t.timestamps
    end
  end
end
