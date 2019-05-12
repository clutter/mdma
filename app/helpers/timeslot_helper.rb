# Methods related to visualizing timeslots
module TimeslotHelper
  def prefixes_for(timeslot)
    timeslot.prefixes.sort.to_sentence.presence || 'all'
  end

  def push_app_button_to(device, disabled:)
    attributes = { class: 'btn btn-primary btn-sm', method: :patch }
    attributes[:disabled] = 'disabled' if disabled
    button_to 'Push app', device, attributes
  end
end
