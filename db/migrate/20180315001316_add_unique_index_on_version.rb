class AddUniqueIndexOnVersion < ActiveRecord::Migration[5.2]
  def change
    change_column_null :builds, :version, false
    add_index :builds, :version, unique: true
  end
end
