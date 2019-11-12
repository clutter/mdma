# Exposes an endpoint for third-party APIs to create internal builds.
class API::BuildsController < API::ApplicationController
  def create
    build = Build.new(build_params)

    if build.save
      head :created
    else
      render json: { message: build.error_message }, status: :bad_request
    end
  end

private

  def build_params
    params.require(:build).permit :version, :package
  end
end
