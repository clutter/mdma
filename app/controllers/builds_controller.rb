class BuildsController < ApplicationController
  before_action :require_authentication
  before_action :set_build, only: [:show, :edit]

  def index
    @builds = Build.all
  end

  def show
  end

  def new
    @build = Build.new
  end

  def create
    @build = Build.new(build_params)

    if @build.save
      redirect_to @build, notice: 'Build was successfully created.'
    else
      render :new
    end
  end

private

  def set_build
    @build = Build.find(params[:id])
  end

  def build_params
    params.require(:build).permit :deploy_date, :deploy_time, :package
  end
end
