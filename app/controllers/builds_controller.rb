# typed: false

# Displays the latest external builds and shows a form to create new ones.
class BuildsController < ApplicationController
  before_action :require_authentication

  def index
    @builds = Build.external.with_attachments.includes(:deploy).order(deploy_at: :desc)
  end

  def new
    @build = Build.new(deploy_date: Date.tomorrow, deploy_time: Time.strptime('20:00', '%H:%M'))
  end

  def create
    @build = Build.new(build_params)
    @build.deploy_date = @build.deploy_date
    @build.deploy_time = @build.deploy_time

    if @build.save
      redirect_to @build.external? ? root_url : internal_builds_url
    else
      render :new
    end
  end

private

  def build_params
    params.require(:build).permit :deploy_date, :deploy_time, :package
  end
end
