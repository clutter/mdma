# typed: false

# Generates and attaches a manifest to allow manually installing a build.
class GenerateManifestJob < ActiveJob::Base
  queue_as :default

  def perform(build)
    @build = build
    @info_plist = PackageAnalyzer.new(@build.package.blob).metadata

    return if @info_plist.empty?

    update_metadata
    attach_manifest
  end

private

  def update_metadata
    @build.package.blob.update! metadata: @info_plist
  end

  def attach_manifest
    Tempfile.open ['manifest', '.plist'] do |file|
      file.write manifest_data
      file.rewind
      @build.manifest.attach io: File.open(file.path), filename: 'manifest.plist'
    end
  end

  def manifest_data
    <<~MANIFEST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>items</key>
        <array>
          <dict>
            <key>assets</key>
            <array>
              <dict>
                <key>kind</key>
                <string>software-package</string>
                <key>url</key>
                <string>#{package_url}</string>
              </dict>
            </array>
            <key>metadata</key>
            <dict>
              <key>bundle-identifier</key>
              <string>#{@info_plist[:bundle_identifier]}</string>
              <key>bundle-version</key>
              <string>#{@info_plist[:bundle_short_version]}</string>
              <key>kind</key>
              <string>software</string>
              <key>subtitle</key>
              <string>#{@info_plist[:bundle_display_name]}</string>
              <key>title</key>
              <string>#{@info_plist[:bundle_display_name]}</string>
            </dict>
          </dict>
        </array>
      </dict>
      </plist>
    MANIFEST
  end

  def package_url
    ActiveStorage::Current.host = 'http://localhost:3000' if local?
    CGI.escapeHTML @build.package.blob.service_url(expires_in: Build::MANIFEST_EXPIRES_IN)
  end

  def local?
    Rails.application.config.active_storage.service.in? %i[local test]
  end
end
