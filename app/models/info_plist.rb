require 'cfpropertylist'

# Parses attributes from a package attachment’s Info.plist.
# Adapted from https://github.com/soulchild/antenna/blob/master/lib/antenna/infoplist.rb
class InfoPlist
  attr_accessor :bundle_display_name, :bundle_identifier, :bundle_short_version, :bundle_version, :bundle_minimum_os_version

  def initialize(data)
    info_plist = CFPropertyList::List.new data: data
    info_plist_data = CFPropertyList.native_types info_plist.value

    @bundle_display_name        = info_plist_data["CFBundleDisplayName"] || info_plist_data["CFBundleName"]
    @bundle_identifier          = info_plist_data["CFBundleIdentifier"]
    @bundle_short_version       = info_plist_data["CFBundleShortVersionString"]
    @bundle_version             = info_plist_data["CFBundleVersion"]
    @bundle_minimum_os_version  = info_plist_data["MinimumOSVersion"]
  end
end
