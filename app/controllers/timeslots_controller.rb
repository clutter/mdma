# Displays the diffent timezones when the build should be deployed.
class TimeslotsController < ApplicationController
  before_action :require_authentication

  def index
    @timeslots = Timeslot.enabled.order(:delay_in_hours)
  end

  def show
    @timeslot = Timeslot.enabled.find params[:id]
  end
end
