# A single build includes the package file to send to the devices.
class Build < ActiveRecord::Base
  has_one_attached :package
  validates :package_attachment, presence: true

  has_many :deploys, dependent: :destroy

  attr_accessor :deploy_date, :deploy_time
  validates :deploy_date, :deploy_time, presence: true, on: :create
  validate on: :create do
    begin
      self.deploy_date = Date.strptime deploy_date, '%Y-%m-%d'
      if deploy_date < Time.zone.today
        errors.add :deploy_date, 'must be in the future'
      end
    rescue ArgumentError
      errors.add :deploy_date, 'has an invalid format'
    end if deploy_date.present?

    begin
      self.deploy_time = Time.zone.strptime deploy_time, '%H:%M'
      if deploy_date == Time.zone.today && deploy_time < Time.zone.now
        errors.add :deploy_time, 'must be in the future'
      end
    rescue ArgumentError
      errors.add :deploy_time, 'has an invalid format'
    end if deploy_time.present?
  end

  before_create do
    self.deploy_at ||= deploy_date + deploy_time.seconds_since_midnight.seconds
  end

  before_create do
    self.deploys = Timeslot.enabled.map { |timeslot| Deploy.new timeslot: timeslot }
  end
end
