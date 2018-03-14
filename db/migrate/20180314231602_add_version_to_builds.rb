class AddVersionToBuilds < ActiveRecord::Migration[5.2]
  def change
    add_column :builds, :version, :integer
  end
end
