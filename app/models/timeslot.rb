class Timeslot < ActiveRecord::Base
  has_many :deploys, dependent: :destroy
  scope :enabled, -> { where(enabled: true) }
end
