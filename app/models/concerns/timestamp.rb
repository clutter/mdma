# Provides two accessors (date, time) to obtain date and time separately as
# Strings and validate presence, format, and future-ness.
module Timestamp
  extend ActiveSupport::Concern

  class_methods do
    def has_timestamp
      include TimestampMethods
      validate_timestamp
    end
  end
end

module TimestampMethods
  extend ActiveSupport::Concern

  included do
    attr_accessor :date, :time
    store_accessor :data, :timestamp
  end

  class_methods do
    def validate_timestamp(options = {})
      with_options options do
        with_options on: :create do
          before_validation :trim_timestamp_accessors
          validates :date, :time, presence: true
          validates :date, date_format: :us
          validates :time, time_format: :us
          validates :time, future_time: {date: :date, format: :us}
        end
        before_create :set_timestamp_from_accessors
      end
    end
  end

  def trim_timestamp_accessors
    self.date = date.upcase.tr ' ', ''
    self.time = time.upcase.tr ' ', ''
  end

  def set_timestamp_from_accessors
    date = Date.strptime self.date, I18n.t('date.formats')[:us]
    time = Time.strptime self.time, I18n.t('time.formats')[:us]
    self.timestamp = date + time.seconds_since_midnight.seconds
  end
end
