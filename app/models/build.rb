class Build < ApplicationRecord
  has_one_attached :package

  after_commit :schedule_deploy, on: :create

private

  def schedule_deploy
    DeployPackageJob.set(wait_until: deployed_at).perform_later(self)
  end
end
