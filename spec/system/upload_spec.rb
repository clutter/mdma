RSpec.describe 'Uploading a build', :logged_in, :running_jobs do
  before { visit new_build_url }
  let(:version) { '1234' }
  let(:local_file) { Rails.root.join file_fixture('demo.ipa') }

  context 'with valid data' do
    before do
      attach_file 'Choose the .ipa package for this build:', local_file
      fill_in 'Version', with: version
      fill_in 'Deploy date', with: Date.parse('2020-03-12')
      click_on 'Upload and deploy'
    end

    it 'displays the deploy' do
      expect(page).to have_text(version)
      expect(page).to have_text('on Thursday, March 12, 2020 at 3:00AM PDT')
      expect(page).to have_link('Install')
    end

    context 'given some timeslots' do
      before(:all) { Timeslot.first_or_create! }

      it 'lets users cancel a specific build for a timeslot' do
        expect(page).to have_text('scheduled')
        first(:button, 'Cancel').click
        expect(page).to have_text('canceled')
      end
    end
  end

  specify 'with invalid data, displays errors' do
    text_fill_in 'Deploy date', with: 'abc'
    text_fill_in 'Deploy time', with: 'abc'
    click_on 'Upload and deploy'

    expect(page).to have_text %(Package can't be blank.)
    expect(page).to have_text %(Version can't be blank.)
    expect(page).to have_text %(Deploy date has an invalid format.)
    expect(page).to have_text %(Deploy time has an invalid format.)
  end
end

private

# Needed to override Chrome-specific browser validation.
def text_fill_in(locator, options = {})
  id = find_field(locator).native[:id]
  evaluate_script "document.getElementById('#{id}').type = 'text'"
  fill_in locator, options
end
