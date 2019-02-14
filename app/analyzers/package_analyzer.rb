require 'zip'
require 'zip/filesystem'

class PackageAnalyzer < ActiveStorage::Analyzer
  def metadata
    read_info_plist do |info_plist|
      return {} unless info_plist

      {
        bundle_display_name: info_plist.bundle_display_name,
        bundle_identifier: info_plist.bundle_identifier,
        bundle_short_version: info_plist.bundle_short_version,
        bundle_version: info_plist.bundle_version,
        bundle_minimum_os_version: info_plist.bundle_minimum_os_version,
      }.compact
    end
  end

private

  def read_info_plist
    download_blob_to_tempfile do |file|
      yield IPA.new(file.path).info_plist
    end
  end
end
