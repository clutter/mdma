RSpec.describe 'The devices page', :logged_in do
  before { visit devices_url }

  context 'given I click on Refresh Devices' do
    before { click_on 'Refresh devices' }

    it 'displays devices' do
      expect(page).to have_css 'tbody tr'
    end
  end
end
