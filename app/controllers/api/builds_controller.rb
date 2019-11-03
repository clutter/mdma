# Allows a third-party client to upload a new build
class API::BuildsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  # Example Create Request:
  # curl -X POST \
  #   -H "Authorization: Token token=[mdma_token]" \
  #   -H "Content-Type: multipart/form-data" \
  #   -F "package=@[ipa_path]" \
  #   -F "title=\"[title]\"" \
  #   http://[host]/api/builds

  def create
    @build = Build.new(build_params)

    if @build.save
      render head: :ok
    else
      render json: { message: @build.errors.full_messages.first }, status: :bad_request
    end
  end

private

  def build_params
    params.permit :title, :package
  end

  def authentication_token
    ENV['MDMA_TOKEN']
  end

  def authenticate
    return false if authentication_token.blank?

    authenticate_or_request_with_http_token do |token, _|
      ActiveSupport::SecurityUtils.secure_compare(token, authentication_token)
    end
  end
end
