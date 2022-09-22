# typed: false

RSpec.describe 'The home-page' do
  before { visit root_url }

  it 'displays a link to log in' do
    expect(page).to have_link('Log in with your @clutter.com email')
  end
end
