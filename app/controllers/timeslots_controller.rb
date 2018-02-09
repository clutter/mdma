class TimeslotsController < ApplicationController
  before_action :require_authentication

  def index
    @timeslots = Timeslot.enabled.order(:delay_in_hours)
  end
end
