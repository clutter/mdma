# Methods related to visualizing timeslots
module TimeslotHelper
  def prefixes_for(timeslot)
    timeslot.prefixes.sort.to_sentence.presence || 'all'
  end
end
