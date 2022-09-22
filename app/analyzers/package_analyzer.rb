# typed: true

require 'cfpropertybundle'

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
    download_blob_to_tempfile do |ipa_file|
      CFPropertyBundle.new(ipa_file).metadata
    end
  end
end
