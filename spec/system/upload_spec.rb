# typed: false

RSpec.describe 'Uploading a build', :logged_in, :running_jobs do
  before { visit new_build_url }

  context 'with a file' do
    before { attach_file 'Choose the .ipa package for this build:', file }

    context 'that is a valid IPA' do
      let(:version) { 42 }
      let(:file) { Rails.root.join file_fixture("demo_v#{version}.ipa") }

      context 'and a deploy date' do
        before do
          text_fill_in 'Deploy date', with: deploy_date
          click_on 'Upload and deploy'
        end

        context 'in the future' do
          let(:deploy_date) { Date.parse('2030-03-12') }

          it 'displays the external build' do
            expect(page).to have_text(version)
            expect(page).to have_text('on Tuesday, March 12, 2030 at 3:00AM PDT')
            expect(page).to have_link('Install')
          end

          it 'lets users cancel the build' do
            expect(page).to have_text('scheduled')
            first(:button, 'Cancel').click
            expect(page).to have_text('canceled')
          end

          it 'does not accept the same file twice' do
            visit new_build_url
            attach_file 'Choose the .ipa package for this build:', file
            click_on 'Upload and deploy'
            expect(page).to have_text %(Version has already been taken)
          end
        end

        context 'in the past' do
          let(:deploy_date) { Date.parse('2010-03-12') }

          it 'displays errors' do
            expect(page).to have_text %(Deploy date must be in the future)
          end
        end

        context 'in an invalid format' do
          let(:deploy_date) { 'abc' }

          it 'displays errors' do
            expect(page).to have_text %(Deploy date has an invalid format)
          end
        end
      end

      context 'and no deploy date' do
        before do
          click_on 'Upload and deploy'
        end

        it 'displays the internal build' do
          expect(page).to have_text(version)
          expect(page).to have_link('Install')
        end
      end
    end

    context 'that is not a valid IPA' do
      let(:file) { Rails.root.join file_fixture('empty.png') }

      it 'displays errors' do
        click_on 'Upload and deploy'
        expect(page).to have_text %(Version cannot be extracted from the attachment)
      end
    end
  end

  context 'without a file' do
    before do
      click_on 'Upload and deploy'
    end

    it 'displays errors' do
      expect(page).to have_text %(Package can't be blank)
    end
  end
end

private

# Needed to override Chrome-specific browser validation.
def text_fill_in(locator, options = {})
  id = find_field(locator).native[:id]
  evaluate_script "document.getElementById('#{id}').type = 'text'"
  fill_in locator, options
end
