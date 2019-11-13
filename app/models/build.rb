require 'cfpropertybundle'

# A single build includes the package file to send to the devices.
class Build < ActiveRecord::Base
  has_one_attached :package
  has_one_attached :manifest
  validates :package, presence: true

  has_one :deploy, dependent: :destroy

  scope :external, -> { where.not(deploy_at: nil) }
  scope :internal, -> { where(deploy_at: nil) }

  scope :with_attachments, -> { with_attached_package.with_attached_manifest }

  before_validation :set_version, on: :create, if: -> { package.attached? }
  validates :version, presence: true, uniqueness: true

  attr_accessor :deploy_date, :deploy_time
  validate on: :create do
    validate_future_date if deploy_date.present?
    validate_future_time if deploy_time.present?
  end

  before_create :set_deploy_at, if: -> { deploy_date.present? && deploy_time.present? }
  before_create :create_deploy, if: :external?

  after_create_commit prepend: true do
    GenerateManifestJob.perform_later self
  end

  MANIFEST_EXPIRES_IN = 1.week

  def has_valid_manifest?
    manifest.attached? && (manifest.attachment.created_at + MANIFEST_EXPIRES_IN).future?
  end

  def external?
    deploy_at.present?
  end

  def error_message
    errors.full_messages.to_sentence
  end

private

  def set_version
    file = attachment_changes['package'].attachable
    metadata = CFPropertyBundle.new(file).metadata
    self.version = metadata[:bundle_version]
  rescue CFPropertyBundle::Error
    errors.add(:version, :invalid, message: 'cannot be extracted from the attachment')
  end

  def validate_future_date
    self.deploy_date = Date.strptime deploy_date, '%Y-%m-%d'
    errors.add :deploy_date, 'must be in the future' if deploy_date < Time.zone.today
  rescue ArgumentError
    errors.add :deploy_date, 'has an invalid format'
  end

  def validate_future_time
    self.deploy_time = Time.zone.strptime deploy_time, '%H:%M'
    errors.add :deploy_time, 'must be in the future' if deploy_date == Time.zone.today && deploy_time < Time.zone.now
  rescue ArgumentError
    errors.add :deploy_time, 'has an invalid format'
  end

  def set_deploy_at
    self.deploy_at ||= deploy_date + deploy_time.seconds_since_midnight.seconds
  end

  def create_deploy
    self.deploy = Deploy.new
  end
end
