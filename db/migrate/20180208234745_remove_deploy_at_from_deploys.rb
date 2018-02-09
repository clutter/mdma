class RemoveDeployAtFromDeploys < ActiveRecord::Migration[5.2]
  def change
    remove_column :deploys, :deploy_at, :datetime
  end
end
