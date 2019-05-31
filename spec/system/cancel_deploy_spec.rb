RSpec.describe 'Clicking the cancel button', :logged_in do
  before { create_timeslots }
  before { upload_build }

  let(:deploy_one_delay) { '0 hours' }
  let(:deploy_two_delay) { '8 hours' }
  let(:local_file) { Rails.root.join file_fixture('demo.ipa') }

  specify 'cancels the correct deploy' do
    rowToKeepScheduled = find('tr', text: deploy_one_delay)
    expect(rowToKeepScheduled).to have_text('scheduled')
    expect(rowToKeepScheduled).to have_button('Cancel')

    rowToCancel = find('tr', text: deploy_two_delay)
    expect(rowToCancel).to have_text('scheduled')
    expect(rowToCancel).to have_button('Cancel')

    rowToCancel.click_button('Cancel')

    expect(rowToKeepScheduled).to have_text('scheduled')
    expect(rowToKeepScheduled).to have_button('Cancel')

    expect(rowToCancel).to have_text('canceled')
    expect(rowToCancel).to_not have_button('Cancel')
  end
end

private

def create_timeslots()
  Timeslot.destroy_all
  Timeslot.create(prefixes: ['HQ'], delay_in_hours: 0)
  Timeslot.create(prefixes: ['LA'], delay_in_hours: 8)
end

def upload_build()
  visit new_build_url
  attach_file 'Choose the .ipa package for this build:', local_file
  fill_in 'Version', with: '123'
  fill_in 'Deploy date', with: Date.parse('2020-03-12')
  click_on 'Upload and deploy'
end
