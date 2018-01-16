# Extend simplemdm Ruby API to support refresh
module SimpleMDM
  class Device < Base
    def refresh
      raise "You cannot refresh device that hasn't been created yet." if new?
      hash, code = fetch("devices/#{id}/refresh", :post)
      code == 202
    end
  end
end
