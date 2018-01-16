class RenameDeployAt < ActiveRecord::Migration[5.2]
  def change
    rename_column :builds, :deployed_at, :deploy_at
  end
end