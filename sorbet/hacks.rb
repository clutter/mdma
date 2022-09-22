# typed: true

# work-arounds for ActiveRecord
module ActiveRecord
  # Hack type issues with `enable_extension psql` in migrations
  class Schema
    def enable_extension(name); end
  end
end
