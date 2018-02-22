# A timeslot identifies a group of regions to deploy to at once.
class Timeslot < ActiveRecord::Base
  has_many :deploys, dependent: :destroy
  scope :enabled, -> { where(enabled: true) }
end
