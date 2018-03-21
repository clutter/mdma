RSpec.describe 'Logging in' do
  before { login_as email }

  context 'as a non-Clutter user' do
    let(:email) { 'test@example.com' }

    it 'displays an authentication error' do
      expect(page).to have_text('Authentication failed')
    end
  end

  context 'as a Clutter user' do
    let(:email) { 'test@clutter.com' }

    it 'displays the app' do
      expect(page).to have_text('mdma')
    end
  end
end

private

def login_as(email)
  authentication = double
  expect(authentication).to receive(:email).and_return email
  expect(Yt::Auth).to receive(:create).and_return(authentication)

  visit auth_sessions_url
end
