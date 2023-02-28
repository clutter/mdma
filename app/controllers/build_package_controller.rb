class BuildPackageController < ApplicationController
    def show
        @build = Build.find_signed(params[:id])
        redirect_to @build.package.service_url
    end
end
