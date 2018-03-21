RSpec.describe 'The timeslots page', :logged_in do
  before { visit timeslots_url }

  context 'given some timeslots' do
    it 'displays prefixes and delays of each enabled timeslot' do
      expect(page).to have_css 'tbody tr'
    end
  end
end
