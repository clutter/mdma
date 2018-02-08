class Timeslot < ActiveRecord::Base
  has_many :deploys, dependent: :destroy
end
