class DeleteBuildsWithoutVersion < ActiveRecord::Migration[5.2]
  def up
    Build.where(version: nil).destroy_all
  end
  
  def down    
  end
end
