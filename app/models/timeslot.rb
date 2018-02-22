# A timeslot identifies a group of regions to deploy to at once.
class Timeslot < ActiveRecord::Base
  has_many :deploys, dependent: :destroy
  scope :enabled, -> { where(enabled: true) }

  before_validation :set_default_values, on: :create

private

  def set_default_values
    self.delay_in_hours ||= 0
    self.prefixes ||= ['']
  end
end
