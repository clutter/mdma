require 'zip'
require 'zip/filesystem'

# Extracts the Info.plist from a build’s package attachment.
# Adapted from https://github.com/soulchild/antenna/blob/master/lib/antenna/ipa.rb
class IPA
  attr_accessor :info_plist

  def initialize(filename)
    Zip::File.open filename do |zip_file|
      app_name = zip_file.dir.entries('Payload').find { |entry_name| entry_name =~ /.app$/ }
      raise "Unable to determine app name from #{filename}" unless app_name

      info_plist_data = zip_file.get_entry("Payload/#{app_name}/Info.plist").get_input_stream.read
      @info_plist = InfoPlist.new info_plist_data
    end
  rescue
    @info_plist = nil
  end
end
