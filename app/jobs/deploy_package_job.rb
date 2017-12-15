require 'slack'

class DeployPackageJob < ApplicationJob
  queue_as :default

  def perform(build)
    app = SimpleMDM::App.find 55475
    file = Tempfile.open ['package', '.ipa'], encoding: 'ASCII-8BIT'
    file.write build.package.download
    app.binary = file.open
    app.save

    app_group = SimpleMDM::AppGroup.find 21708
    app_group.push_apps
    Slack.notify("New build of UglySweater released.")
  end
end
