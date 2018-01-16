class Build < ApplicationRecord
  has_one_attached :package
  validates :package_attachment, presence: true

  enum status: %i(scheduled enqueued failed successful canceled)

  attr_accessor :deploy_date, :deploy_time
  validates :deploy_date, :deploy_time, presence: true
  validate do
    begin
      self.deploy_date = Date.strptime deploy_date, '%Y-%m-%d'
      if self.deploy_date < Time.zone.today
        errors.add :deploy_date, 'must be in the future'
      end
    rescue ArgumentError
      errors.add :deploy_date, 'has an invalid format'
    end if deploy_date.present?

    begin
      self.deploy_time = Time.strptime deploy_time, '%H:%M'
      if self.deploy_date == Time.zone.today && self.deploy_time < Time.zone.now
        errors.add :deploy_time, 'must be in the future'
      end
    rescue ArgumentError
      errors.add :deploy_time, 'has an invalid format'
    end if deploy_time.present?
  end

  before_create do
    self.deploy_at ||= deploy_date + deploy_time.seconds_since_midnight.seconds
  end

  after_commit :schedule_deploy, on: :create

  def enqueue
    DeployJob.set(wait_until: DateTime.parse(deploy_at)).perform_later self
  end

private

  def schedule_deploy
    DeployPackageJob.set(wait_until: deploy_at).perform_later(self)
  end
end
