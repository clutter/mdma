class Deploy < ActiveRecord::Base
  belongs_to :build
  belongs_to :timeslot

  enum status: %i(scheduled enqueued failed successful canceled running)
end
