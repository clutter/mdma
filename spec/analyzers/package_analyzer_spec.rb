RSpec.describe PackageAnalyzer do
  let(:blob) { ActiveStorage::Blob.create_after_upload! io: file_fixture(filename).open, filename: filename }
  let(:metadata) { PackageAnalyzer.new(blob).metadata }

  describe 'analyzing a valid .ipa file' do
    let(:filename) { 'demo_v42.ipa' }

    it 'correctly parses metadata from its InfoPlist' do
      expect(metadata[:bundle_display_name]).to be_nil
      expect(metadata[:bundle_identifier]).to eq 'com.clutter.UglySweater'
      expect(metadata[:bundle_short_version]).to eq '1.0'
      expect(metadata[:bundle_version]).to eq '42'
      expect(metadata[:bundle_minimum_os_version]).to eq '8.0'
    end
  end
end
