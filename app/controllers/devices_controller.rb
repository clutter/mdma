class DevicesController < ApplicationController
  before_action :require_authentication
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  def index
    @devices = Device.select(:app_version, :name).order('app_version desc nulls last').group_by(&:app_version)
  end

  def show
  end

  def new
    @device = Device.new
  end

  def edit
  end

  def create
    @device = Device.new(device_params)

    if @device.save
      redirect_to @device, notice: 'Device was successfully created.'
    else
      render :new
    end
  end

  def update
    if @device.update(device_params)
      redirect_to @device, notice: 'Device was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @device.destroy
    redirect_to devices_url, notice: 'Device was successfully destroyed.'
  end

private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :app_version)
  end
end
