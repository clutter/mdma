# typed: true

# Displays the latest internal builds and shows a form to create new ones.
class InternalBuildsController < ApplicationController
  before_action :require_authentication

  def index
    @builds = Build.internal.with_attachments.order(version: :desc)
  end
end
