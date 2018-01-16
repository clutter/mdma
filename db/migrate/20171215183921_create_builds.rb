class CreateBuilds < ActiveRecord::Migration[5.2]
  def change
    create_table :builds do |t|
      t.datetime :deploy_at

      t.timestamps
    end
  end
end
