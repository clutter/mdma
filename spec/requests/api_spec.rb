# typed: false
RSpec.describe 'Creating a build via the API' do
  before { post api_builds_url, headers: headers, params: params }
  let(:headers) { {} }
  let(:params) { {} }

  context 'without an authorization token' do
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

      context 'with a file' do
        let(:params) { { build: { package: file_content } } }

        context 'that is a valid IPA' do
          let(:file_content) { fixture_file_upload file_fixture('demo_v42.ipa') }
          it { expect(response).to be_created }
        end

        context 'that is not a valid IPA' do
          let(:file_content) { fixture_file_upload file_fixture('empty.png') }
          it { expect(response).to be_bad_request }
          it { expect(JSON(response.body)['message']).to be_a String }
        end
      end

      context 'without a file' do
        it { expect(response).to be_bad_request }
        it { expect(JSON(response.body)['message']).to be_a String }
      end
    end
  end
end
