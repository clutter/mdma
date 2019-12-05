RSpec.describe 'Logging in' do
  before { login_as email }

  context 'from an unauthorized domain' do
    let(:email) { 'test@example.com' }

    it 'displays an authentication error' do
      expect(page).to have_text('Authentication failed')
    end
  end

  context 'from an authorized domain' do
    let(:email) { 'test@clutter.com' }

    it 'displays the app' do
      expect(page).to have_text('mdma')
    end
  end
end

private

def login_as(email)
  ENV['EMAIL_DOMAIN'] = '@clutter.com'
  authentication = double
  expect(authentication).to receive(:email).and_return email
  expect(Yt::Auth).to receive(:create).and_return(authentication)

  visit auth_sessions_url
end
