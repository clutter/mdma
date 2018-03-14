class BackfillVersionsOnBuilds < ActiveRecord::Migration[5.2]
  def up
    Build.where(deploy_at: '2018-01-17 22:30:00 -0800').update_all version: 1849
    Build.where(deploy_at: '2018-01-22 22:20:00 -0800').update_all version: 1891
    Build.where(deploy_at: '2018-02-01 20:00:00 -0800').update_all version: 1926
    Build.where(deploy_at: '2018-02-08 20:00:00 -0800').update_all version: 1949
    Build.where(deploy_at: '2018-02-11 20:00:00 -0800').update_all version: 1958
    Build.where(deploy_at: '2018-02-12 20:00:00 -0800').update_all version: 1969
    Build.where(deploy_at: '2018-02-13 20:00:00 -0800').update_all version: 1976
    Build.where(deploy_at: '2018-02-14 20:00:00 -0800').update_all version: 1985
    Build.where(deploy_at: '2018-02-22 20:00:00 -0800').update_all version: 1993
    Build.where(deploy_at: '2018-02-27 20:00:00 -0800').update_all version: 2010
    Build.where(deploy_at: '2018-03-01 20:00:00 -0800').update_all version: 2034
    Build.where(deploy_at: '2018-03-06 20:00:00 -0800').update_all version: 2043
    Build.where(deploy_at: '2018-03-12 20:00:00 -0700').update_all version: 2050
  end

  def down
    Build.update_all version: nil
  end
end
