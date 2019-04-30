# A timeslot identifies a group of regions to deploy to at once.
class Timeslot < ActiveRecord::Base
  has_many :deploys, dependent: :destroy
  scope :enabled, -> { where(enabled: true) }

  before_validation :set_default_values, on: :create

  def devices
    Device.where("name ~ '^(#{prefixes.join('|')})'")
  end

  def expected_version
    @expected_version ||= last_successful_deploy ? last_successful_deploy.build.version : 'Not yet deployed'
  end

private

  def set_default_values
    self.delay_in_hours ||= 0
    self.prefixes ||= ['']
  end

  def last_successful_deploy
    deploys.successful.order(:created_at).last
  end
end
