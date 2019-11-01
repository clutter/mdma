module Api
  # Returns the list of builds
  class BuildsController < ActionController::API
    def index
      @builds = Build.includes(deploys: :timeslot).order(deploy_at: :desc)
      render json: @builds.as_json(only: %i[version deploy_at], include: {
        deploys: {only: %i[status], include: {
          timeslot: {only: %i[prefixes delay_in_hours]}
        }
      }})
    end
  end
end
