# typed: true

module Builds
  # Controller to handle setting the build that is the minimum supported version.
  class MinimumSupportedVersionsController < ApplicationController
    before_action :require_authentication

    # /builds/:id/minimum_supported_version
    def update
      Build.find(params[:build_id]).update!(minimum_supported_version: true)
      redirect_back fallback_location: root_path, notice: 'New minimum supported version.'
    end
  end
end
