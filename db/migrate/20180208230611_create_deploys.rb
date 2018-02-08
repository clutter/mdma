class CreateDeploys < ActiveRecord::Migration[5.2]
  def change
    create_table :deploys do |t|
      t.references :build, foreign_key: true
      t.datetime :deploy_at
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
