class Deploy < ActiveRecord::Base
  belongs_to :build

  enum status: %i(scheduled enqueued failed successful canceled running)
end
