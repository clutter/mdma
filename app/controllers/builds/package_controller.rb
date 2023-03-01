module Builds
  # Redirects to the approriate package to avoid expiration issues
  class PackageController < ApplicationController
    def show
      @build = Build.find_signed(params[:signed_build_id])
      redirect_to(@build.package.service_url)
    end
  end
end
