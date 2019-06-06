# A single build includes the package file to send to the devices.
class Build < ActiveRecord::Base
  has_one_attached :package
  has_one_attached :manifest
  validates :package, presence: true

  has_many :deploys, -> { joins(:timeslot).order 'timeslots.delay_in_hours' }, dependent: :destroy

  attr_accessor :deploy_date, :deploy_time
  validates :version, :deploy_date, :deploy_time, presence: true, on: :create
  validates :version, uniqueness: true
  validate on: :create do
    validate_future_date if deploy_date.present?
    validate_future_time if deploy_time.present?
  end

  before_create do
    self.deploy_at ||= deploy_date + deploy_time.seconds_since_midnight.seconds
  end

  before_create do
    self.deploys = Timeslot.enabled.map { |timeslot| Deploy.new timeslot: timeslot }
  end

  after_create_commit prepend: true do
    GenerateManifestJob.perform_later self
  end

private

  def validate_future_date
    self.deploy_date = Date.strptime deploy_date, '%Y-%m-%d'
    errors.add :deploy_date, 'must be in the future' if deploy_date < Time.zone.today
  rescue ArgumentError
    errors.add :deploy_date, 'has an invalid format'
  end

  def validate_future_time
    self.deploy_time = Time.zone.strptime deploy_time, '%H:%M'
    errors.add :deploy_time, 'must be in the future' if deploy_date == Time.zone.today && deploy_time < Time.zone.now
  rescue ArgumentError
    errors.add :deploy_time, 'has an invalid format'
  end
end
