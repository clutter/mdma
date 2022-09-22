# typed: true

class ChangeVersionToBeStringInBuild < ActiveRecord::Migration[5.2]
  def change
    change_column :builds, :version, :string
  end
end
