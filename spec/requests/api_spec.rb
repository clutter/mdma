RSpec.describe 'Creating a build via the API' do
  before { post api_builds_url, headers: headers, params: { build: build_params } }
  let(:build_params) { { version: version, package: local_file_content } }
  let(:version) { '1234' }
  let(:local_file_content) { fixture_file_upload file_fixture('demo.ipa') }

  context 'without an authorization token' do
    let(:headers) { {} }
    it { expect(response).to be_unauthorized }
  end

  context 'with an authorization token' do
    let(:headers) { { Authorization: "Token token=#{token}" } }
    ENV['MDMA_TOKEN'] = SecureRandom.hex

    context 'that does not match the expected token' do
      let(:token) { 'something-else' }
      it { expect(response).to be_unauthorized }
    end

    context 'that matches the expected token' do
      let(:token) { ENV['MDMA_TOKEN'] }

      context 'given invalid params' do
        let(:version) { '' }
        it { expect(response).to be_bad_request }
        it { expect(JSON(response.body)['message']).to be_a String }
      end

      context 'given valid params' do
        it { expect(response).to be_created }
      end
    end
  end
end
