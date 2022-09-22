# typed: true

class ChangeVersionToBeStringInDevice < ActiveRecord::Migration[5.2]
  def change
    change_column :devices, :app_version, :string
  end
end
