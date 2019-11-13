require 'zip'
require 'zip/filesystem'
require 'cfpropertylist'

# Extracts Core Foundation properties from an IPA file.
class CFPropertyBundle
  def initialize(file)
    @file = file
  end

  def metadata
    Zip::File.open(@file.path) do |package|
      plist_data = extract_plist_data_from package
      plist_dict = CFPropertyList::List.new(data: plist_data).value
      plist_hash = CFPropertyList.native_types plist_dict
      relevant_keys.transform_values { |identifier| plist_hash[identifier] }.compact
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
