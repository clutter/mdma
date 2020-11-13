# typed: false
# Cancels a scheduled build from being deployed.
class DeploysController < ApplicationController
  before_action :require_authentication

  def destroy
    deploy = Deploy.find(params[:id])
    deploy.canceled!
    redirect_back fallback_location: root_path
  end
end
