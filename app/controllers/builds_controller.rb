# Displays the latest build and shows a form to create new ones.
class BuildsController < ApplicationController
  before_action :require_authentication
  before_action :set_build, only: %i[show edit]

  def index
    @builds = Build.with_attached_package.includes(deploys: :timeslot).order(deploy_at: :desc)
  end

  def show; end

  def new
    @build = Build.new deploy_time: Time.strptime('22:30', '%H:%M')
  end

  def create
    @build = Build.new(build_params)

    if @build.save
      redirect_to root_url
    else
      render :new
    end
  end

private

  def set_build
    @build = Build.find(params[:id])
  end

  def build_params
    params.require(:build).permit :version, :deploy_date, :deploy_time, :package
  end
end
