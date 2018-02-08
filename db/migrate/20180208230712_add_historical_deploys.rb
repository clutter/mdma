class AddHistoricalDeploys < ActiveRecord::Migration[5.2]
  def up
    Build.find_each do |build|
      build.deploys.create! deploy_at: build.deploy_at, status: build.status
    end
  end

  def down
    Deploy.destroy_all
  end
end
