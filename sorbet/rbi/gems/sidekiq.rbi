# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/sidekiq/all/sidekiq.rbi
#
# sidekiq-5.2.7

module Sidekiq
  def self.average_scheduled_poll_interval=(interval); end
  def self.client_middleware; end
  def self.configure_client; end
  def self.configure_server; end
  def self.death_handlers; end
  def self.default_retries_exhausted=(prok); end
  def self.default_server_middleware; end
  def self.default_worker_options; end
  def self.default_worker_options=(hash); end
  def self.dump_json(object); end
  def self.error_handlers; end
  def self.load_json(string); end
  def self.logger; end
  def self.logger=(log); end
  def self.on(event, &block); end
  def self.options; end
  def self.options=(opts); end
  def self.redis; end
  def self.redis=(hash); end
  def self.redis_info; end
  def self.redis_pool; end
  def self.server?; end
  def self.server_middleware; end
end
module Sidekiq::Logging
  def logger; end
  def self.initialize_logger(log_target = nil); end
  def self.job_hash_context(job_hash); end
  def self.logger; end
  def self.logger=(log); end
  def self.reopen_logs; end
  def self.tid; end
  def self.with_context(msg); end
  def self.with_job_hash_context(job_hash, &block); end
end
class Sidekiq::Logging::Pretty < Logger::Formatter
  def call(severity, time, program_name, message); end
  def context; end
end
class Sidekiq::Logging::WithoutTimestamp < Sidekiq::Logging::Pretty
  def call(severity, time, program_name, message); end
end
module Sidekiq::Middleware
end
class Sidekiq::Middleware::Chain
  def add(klass, *args); end
  def clear; end
  def each(&block); end
  def entries; end
  def exists?(klass); end
  def initialize; end
  def initialize_copy(copy); end
  def insert_after(oldklass, newklass, *args); end
  def insert_before(oldklass, newklass, *args); end
  def invoke(*args); end
  def prepend(klass, *args); end
  def remove(klass); end
  def retrieve; end
  include Enumerable
end
class Sidekiq::Middleware::Entry
  def initialize(klass, *args); end
  def klass; end
  def make_new; end
end
class Sidekiq::Client
  def atomic_push(conn, payloads); end
  def initialize(redis_pool = nil); end
  def middleware(&block); end
  def normalize_item(item); end
  def normalized_hash(item_class); end
  def process_single(worker_class, item); end
  def push(item); end
  def push_bulk(items); end
  def raw_push(payloads); end
  def redis_pool; end
  def redis_pool=(arg0); end
  def self.enqueue(klass, *args); end
  def self.enqueue_in(interval, klass, *args); end
  def self.enqueue_to(queue, klass, *args); end
  def self.enqueue_to_in(queue, interval, klass, *args); end
  def self.push(item); end
  def self.push_bulk(items); end
  def self.via(pool); end
end
module Sidekiq::Worker
  def jid; end
  def jid=(arg0); end
  def logger; end
  def self.included(base); end
end
class Sidekiq::Worker::Setter
  def initialize(klass, opts); end
  def perform_async(*args); end
  def perform_at(interval, *args); end
  def perform_in(interval, *args); end
  def set(options); end
end
module Sidekiq::Worker::ClassMethods
  def client_push(item); end
  def delay(*args); end
  def delay_for(*args); end
  def delay_until(*args); end
  def get_sidekiq_options; end
  def perform_async(*args); end
  def perform_at(interval, *args); end
  def perform_in(interval, *args); end
  def set(options); end
  def sidekiq_class_attribute(*attrs); end
  def sidekiq_options(opts = nil); end
  def sidekiq_retries_exhausted(&block); end
  def sidekiq_retry_in(&block); end
end
class Sidekiq::RedisConnection
  def self.build_client(options); end
  def self.client_opts(options); end
  def self.create(options = nil); end
  def self.determine_redis_provider; end
  def self.log_info(options); end
  def self.verify_sizing(size, concurrency); end
end
module Sidekiq::Extensions
  def self.enable_delay!; end
end
module Sidekiq::Extensions::PsychAutoload
  def resolve_class(klass_name); end
end
class Sidekiq::Rails < Rails::Engine
end
class Sidekiq::Rails::Reloader
  def call; end
  def initialize(app = nil); end
  def inspect; end
end
class Sidekiq::Shutdown < Interrupt
end
