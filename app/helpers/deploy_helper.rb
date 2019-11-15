# Methods related to visualizing deploys
module DeployHelper
  def table_class_for(deploy)
    "table-#{table_classes[deploy.status.to_sym]}"
  end

  def cancel_deploy_button(deploy_id)
    button_to 'Cancel', deploy_path(id: deploy_id), method: :delete, class: 'btn btn-link text-danger'
  end

private

  def table_classes
    @table_classes ||= {}.tap do |classes|
      classes[:enqueued] = :warning
      classes[:successful] = :success
      classes[:failed] = :danger
      classes[:scheduled] = :active
      classes[:running] = :primary
      classes[:canceled] = :info
    end
  end
end
