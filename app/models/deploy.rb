# typed: false

# A single deploy sends a build to all devices.
class Deploy < ActiveRecord::Base
  belongs_to :build

  scope :with_associations, -> { includes(:build).references(:build) }

  enum status: %i[scheduled enqueued failed successful canceled running]

  def timestamp
    build.deploy_at
  end

  def self.enqueue_pending
    with_associations.scheduled.find_each do |deploy|
      deploy.enqueue if deploy.timestamp < 20.minutes.from_now
    end
  end

  def enqueue
    DeployJob.set(wait_until: timestamp).perform_later self
    enqueued!
  end
end
