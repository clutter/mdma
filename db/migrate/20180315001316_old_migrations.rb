# typed: true
class OldMigrations < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'plpgsql'

    create_table 'active_storage_attachments', force: :cascade do |t|
      t.string 'name', null: false
      t.string 'record_type', null: false
      t.bigint 'record_id', null: false
      t.bigint 'blob_id', null: false
      t.datetime 'created_at', null: false
      t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
      t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
    end

    create_table 'active_storage_blobs', force: :cascade do |t|
      t.string 'key', null: false
      t.string 'filename', null: false
      t.string 'content_type'
      t.text 'metadata'
      t.bigint 'byte_size', null: false
      t.string 'checksum', null: false
      t.datetime 'created_at', null: false
      t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
    end

    create_table 'builds', force: :cascade do |t|
      t.datetime 'deploy_at'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.integer 'version', null: false
      t.index ['version'], name: 'index_builds_on_version', unique: true
    end

    create_table 'deploys', force: :cascade do |t|
      t.bigint 'build_id'
      t.integer 'status', default: 0, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.bigint 'timeslot_id'
      t.index ['build_id'], name: 'index_deploys_on_build_id'
      t.index ['timeslot_id'], name: 'index_deploys_on_timeslot_id'
    end

    create_table 'devices', force: :cascade do |t|
      t.string 'name'
      t.integer 'app_version'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['app_version'], name: 'index_devices_on_app_version'
    end

    create_table 'timeslots', force: :cascade do |t|
      t.text 'prefixes', null: false, array: true
      t.integer 'delay_in_hours', null: false
      t.boolean 'enabled', default: true, null: false
      t.index ['delay_in_hours'], name: 'index_timeslots_on_delay_in_hours'
    end

    add_foreign_key 'deploys', 'builds'
    add_foreign_key 'deploys', 'timeslots'
  end
end
