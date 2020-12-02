# typed: false
# Extend SimpleMDM Ruby API to support refresh
module SimpleMDM
  class Device < Base
    # Adds the refresh method to SimpleMDM::Device
    def refresh
      raise "You cannot refresh device that hasn't been created yet." if new?
      hash, code = fetch("devices/#{id}/refresh", :post)
      code == 202
    end

    # Overwrites the fetch method to go through each page.
    def self.all
      devices = []
      starting_after = nil
      more_pages = true

      while more_pages
        params = { limit: 100, starting_after: starting_after }.compact
        resp = RestClient.get "#{SimpleMDM.api_url}devices", params: params
        hash = JSON.parse(resp)
        devices += hash['data'].collect { |d| build d }
        starting_after = hash['data'].last['id']
        more_pages = hash['has_more']
      end

      devices
    end

    # Overwrites the fetch method to go through each page.
    def installed_apps
      installed_apps = []
      starting_after = nil
      more_pages = true

      while more_pages
        params = { limit: 100, starting_after: starting_after }.compact
        resp = RestClient.get "#{SimpleMDM.api_url}devices/#{id}/installed_apps", params: params
        hash = JSON.parse(resp)
        installed_apps.concat hash['data']
        more_pages = hash['has_more']
        starting_after = hash['data'].last['id'] if more_pages
      end

      installed_apps.map { |app| InstalledApp.build app }
    end
  end

  class AppGroup < Base
    def update_apps
      hash, code = fetch("assignment_groups/#{id}/update_apps", :post)

      code == 202
    end
  end
end
