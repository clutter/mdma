# typed: false
# Enqueues deploys that are scheduled in the next 20 minutes
class EnqueuesController < ApplicationController
  before_action :require_authentication

  def create
    Deploy.enqueue_pending
    redirect_back fallback_location: root_path, notice: 'Pending deploys have been enqueued.'
  end
end
