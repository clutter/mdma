# A single deploy sends a build to the devices included in a timeslot.
class Deploy < ActiveRecord::Base
  belongs_to :build
  belongs_to :timeslot

  scope :with_associations, -> { includes(:timeslot, :build).references(:timeslot, :build) }

  enum status: %i[scheduled enqueued failed successful canceled running]

  def includes_device_named?(device_name)
    timeslot.prefixes.any? do |prefix|
      device_name.start_with? prefix
    end
  end

  def timestamp
    build.deploy_at + timeslot.delay_in_hours.hours
  end

  def enqueue
    DeployJob.set(wait_until: timestamp).perform_later self
    enqueued!
  end
end
