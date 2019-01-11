# Adapted from https://github.com/soulchild/antenna/blob/master/spec/infoplist_spec.rb
describe InfoPlist do
  before(:example, legacy: false) do
    @info_plist = InfoPlist.new File.read(Rails.root.join(file_fixture('Info.plist')))
  end

  before(:example, legacy: true) do
    @info_plist = InfoPlist.new File.read(Rails.root.join(file_fixture('Legacy-Info.plist')))
  end

  describe '#initialize' do
    context 'with current Info.plist', legacy: false do
      it 'should parse InfoPlist' do
        expect(@info_plist.bundle_display_name).to eq('UglySweater')
        expect(@info_plist.bundle_identifier).to eq('com.clutter.UglySweater')
        expect(@info_plist.bundle_short_version).to eq('1.0')
        expect(@info_plist.bundle_version).to eq('42')
        expect(@info_plist.bundle_minimum_os_version).to eq('8.0')
      end
    end

    context 'with legacy Info.plist', legacy: true do
      it 'should parse InfoPlist' do
        expect(@info_plist.bundle_display_name).to eq('UglySweater')
        expect(@info_plist.bundle_identifier).to eq('com.clutter.UglySweater')
        expect(@info_plist.bundle_short_version).to eq('1.0')
        expect(@info_plist.bundle_version).to eq('42')
        expect(@info_plist.bundle_minimum_os_version).to eq(nil)
      end
    end
  end
end
