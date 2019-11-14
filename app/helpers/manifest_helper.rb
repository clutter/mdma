# Methods related to a build's manifest.
module ManifestHelper
  def manifest_url(manifest)
    return unless manifest.attached?

    blob_url = rails_blob_url manifest, disposition: 'attachment'
    "itms-services://?action=download-manifest&url=#{CGI.escape blob_url}"
  end
end
