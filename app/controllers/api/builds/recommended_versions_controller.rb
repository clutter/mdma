module API
  module Builds
    # Exposes an endpoint for third-party APIs to see the recommended build version.
    class RecommendedVersionsController < BaseController
      def show
        render(
          json: {
            current_version: latest_build&.version,
            minimum_supported_version: minimum_supported_build.version,
            manifest_url: manifest_url
          },
          status: :ok
        )
      end

    private

      def latest_build
        @latest_build ||= Build.latest_deployed.first
      end

      def minimum_supported_build
        Build.find_by(minimum_supported_version: true)
      end

      def manifest_url
        latest_build ? helpers.manifest_url(latest_build.manifest) : nil
      end
    end
  end
end
