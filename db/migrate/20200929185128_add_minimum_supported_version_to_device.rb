class AddMinimumSupportedVersionToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :builds, :minimum_supported_version, :boolean, default: false

    reversible do |dir|
      dir.up { Build.external.order(id: :asc).first&.update_column(:minimum_supported_version, true) }
    end
  end
end
