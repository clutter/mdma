class AddTitleColumnToBuildsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :builds, :title, :string
  end
end
