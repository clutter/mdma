# Methods related to visualizing deploys
module DeployHelper
  def table_class_for(deploy)
    "table-#{table_classes[deploy.status.to_sym]}"
  end

private

  def table_classes
    @table_classes ||= {}.tap do |classes|
      classes[:enqueued] = :warning
      classes[:successful] = :success
      classes[:failed] = :danger
      classes[:scheduled] = :active
      classes[:running] = :primary
    end
  end
end
