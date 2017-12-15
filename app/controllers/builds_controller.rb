class BuildsController < ApplicationController
  before_action :require_authentication
  before_action :set_build, only: [:show, :edit, :update, :destroy]

  def index
    @builds = Build.all
  end

  def show
  end

  def new
    @build = Build.new
  end

  def edit
  end

  def create
    @build = Build.new(build_params)

    if @build.save
      redirect_to @build, notice: 'Build was successfully created.'
    else
      render :new
    end
  end

  def update
    if @build.update(build_params)
      redirect_to @build, notice: 'Build was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @build.destroy
    redirect_to builds_url, notice: 'Build was successfully destroyed.'
  end

private

  def set_build
    @build = Build.find(params[:id])
  end

  def build_params
    params.require(:build).permit(:deployed_at, :package)
  end
end
