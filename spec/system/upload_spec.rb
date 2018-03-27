RSpec.describe 'Uploading a build', :logged_in do
  before { visit new_build_url }
  let(:version) { '1234' }
  let(:local_file) { Rails.root.join file_fixture('demo.ipa') }

  specify 'with valid data, displays the build' do
    attach_file 'Choose the .ipa package for this build:', local_file
    fill_in 'Version', with: version
    fill_in 'Deploy date', with: '03/12/2020'
    click_on 'Upload and deploy'

    expect(page).to have_text(version)
    expect(page).to have_text('on Thursday, March 12, 2020 at 8:00PM PDT')
  end

  specify 'with invalid data, displays errors' do
    text_fill_in 'Deploy date', with: 'abc'
    text_fill_in 'Deploy time', with: 'abc'
    click_on 'Upload and deploy'

    expect(page).to have_text %(Package attachment can't be blank.)
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
