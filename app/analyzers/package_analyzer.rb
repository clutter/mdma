require 'zip'
require 'zip/filesystem'
require 'cfpropertylist'

# Extracts the following from an iOS App Store Package (.ipa):
#
# * Display Name
# * Identifier
# * Short Version
# * Version
# * Minimum iOS version
#
# Example:
#
#   PackageAnalyzer.new(blob).metadata
#   # => {:bundle_display_name=>"Clutter", :bundle_identifier=>"com.clutter.app",
#         :bundle_short_version=>"1.0", :bundle_version=>"42", :bundle_minimum_os_version=>"11.0"}
class PackageAnalyzer < ActiveStorage::Analyzer
  def metadata
    download_blob_to_tempfile do |file|
      Zip::File.open(file.path) do |package|
        plist_data = extract_plist_data_from package
        plist_dict = CFPropertyList::List.new(data: plist_data).value
        plist_hash = CFPropertyList.native_types plist_dict
        relevant_keys.transform_values { |identifier| plist_hash[identifier] }.compact
      end
    end
  end

private

  def extract_plist_data_from(package)
    app_name = package.dir.entries('Payload').find { |entry_name| entry_name =~ /.app$/ }
    package.get_entry("Payload/#{app_name}/Info.plist").get_input_stream.read
  end

  def relevant_keys
    {
      bundle_display_name: 'CFBundleDisplayName',
      bundle_identifier: 'CFBundleIdentifier',
      bundle_short_version: 'CFBundleShortVersionString',
      bundle_version: 'CFBundleVersion',
      bundle_minimum_os_version: 'MinimumOSVersion'
    }
  end
end
