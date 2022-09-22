# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `minitest` gem.
# Please instead update this file by running `bin/tapioca gem minitest`.

# :include: README.rdoc
#
# source://minitest//lib/minitest/parallel.rb#1
module Minitest
  class << self
    # Internal run method. Responsible for telling all Runnable
    # sub-classes to run.
    #
    # source://minitest//lib/minitest.rb#150
    def __run(reporter, options); end

    # A simple hook allowing you to run a block of code after everything
    # is done running. Eg:
    #
    #   Minitest.after_run { p $debugging_info }
    #
    # source://minitest//lib/minitest.rb#74
    def after_run(&block); end

    # Registers Minitest to run at process exit
    #
    # source://minitest//lib/minitest.rb#52
    def autorun; end

    # source://minitest//lib/minitest.rb#29
    def backtrace_filter; end

    # source://minitest//lib/minitest.rb#29
    def backtrace_filter=(_arg0); end

    # source://minitest//lib/minitest.rb#968
    def clock_time; end

    # source://minitest//lib/minitest.rb#41
    def extensions; end

    # source://minitest//lib/minitest.rb#41
    def extensions=(_arg0); end

    # source://minitest//lib/minitest.rb#235
    def filter_backtrace(bt); end

    # source://minitest//lib/minitest.rb#46
    def info_signal; end

    # source://minitest//lib/minitest.rb#46
    def info_signal=(_arg0); end

    # source://minitest//lib/minitest.rb#78
    def init_plugins(options); end

    # source://minitest//lib/minitest.rb#85
    def load_plugins; end

    # source://minitest//lib/minitest.rb#23
    def parallel_executor; end

    # source://minitest//lib/minitest.rb#23
    def parallel_executor=(_arg0); end

    # source://minitest//lib/minitest.rb#163
    def process_args(args = T.unsafe(nil)); end

    # source://minitest//lib/minitest.rb#36
    def reporter; end

    # source://minitest//lib/minitest.rb#36
    def reporter=(_arg0); end

    # This is the top-level run method. Everything starts from here. It
    # tells each Runnable sub-class to run, and each of those are
    # responsible for doing whatever they do.
    #
    # The overall structure of a run looks like this:
    #
    #   Minitest.autorun
    #     Minitest.run(args)
    #       Minitest.__run(reporter, options)
    #         Runnable.runnables.each
    #           runnable.run(reporter, options)
    #             self.runnable_methods.each
    #               self.run_one_method(self, runnable_method, reporter)
    #                 Minitest.run_one_method(klass, runnable_method)
    #                   klass.new(runnable_method).run
    #
    # source://minitest//lib/minitest.rb#120
    def run(args = T.unsafe(nil)); end

    # source://minitest//lib/minitest.rb#959
    def run_one_method(klass, method_name); end
  end
end

# Defines the API for Reporters. Subclass this and override whatever
# you want. Go nuts.
#
# source://minitest//lib/minitest.rb#546
class Minitest::AbstractReporter
  include ::Mutex_m

  # source://mutex_m/0.1.0/mutex_m.rb#92
  def lock; end

  # source://mutex_m/0.1.0/mutex_m.rb#82
  def locked?; end

  # Did this run pass?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#578
  def passed?; end

  # About to start running a test. This allows a reporter to show
  # that it is starting or that we are in the middle of a test run.
  #
  # source://minitest//lib/minitest.rb#559
  def prerecord(klass, name); end

  # Record a result and output the Runnable#result_code. Stores the
  # result of the run if the run did not pass.
  #
  # source://minitest//lib/minitest.rb#566
  def record(result); end

  # Outputs the summary of the run.
  #
  # source://minitest//lib/minitest.rb#572
  def report; end

  # Starts reporting on the run.
  #
  # source://minitest//lib/minitest.rb#552
  def start; end

  # source://mutex_m/0.1.0/mutex_m.rb#77
  def synchronize(&block); end

  # source://mutex_m/0.1.0/mutex_m.rb#87
  def try_lock; end

  # source://mutex_m/0.1.0/mutex_m.rb#97
  def unlock; end
end

# Represents run failures.
#
# source://minitest//lib/minitest.rb#815
class Minitest::Assertion < ::Exception
  # source://minitest//lib/minitest.rb#816
  def error; end

  # Where was this run before an assertion was raised?
  #
  # source://minitest//lib/minitest.rb#823
  def location; end

  # source://minitest//lib/minitest.rb#832
  def result_code; end

  # source://minitest//lib/minitest.rb#836
  def result_label; end
end

# Minitest Assertions.  All assertion methods accept a +msg+ which is
# printed if the assertion fails.
#
# Protocol: Nearly everything here boils up to +assert+, which
# expects to be able to increment an instance accessor named
# +assertions+. This is not provided by Assertions and must be
# provided by the thing including Assertions. See Minitest::Runnable
# for an example.
#
# source://minitest//lib/minitest/assertions.rb#18
module Minitest::Assertions
  # source://minitest//lib/minitest/assertions.rb#144
  def _synchronize; end

  # Fails unless +test+ is truthy.
  #
  # source://minitest//lib/minitest/assertions.rb#134
  def assert(test, msg = T.unsafe(nil)); end

  # Fails unless +obj+ is empty.
  #
  # source://minitest//lib/minitest/assertions.rb#151
  def assert_empty(obj, msg = T.unsafe(nil)); end

  # Fails unless <tt>exp == act</tt> printing the difference between
  # the two, if possible.
  #
  # If there is no visible difference but the assertion fails, you
  # should suspect that your #== is buggy, or your inspect output is
  # missing crucial details.  For nicer structural diffing, set
  # Minitest::Test.make_my_diffs_pretty!
  #
  # For floats use assert_in_delta.
  #
  # See also: Minitest::Assertions.diff
  #
  # source://minitest//lib/minitest/assertions.rb#172
  def assert_equal(exp, act, msg = T.unsafe(nil)); end

  # For comparing Floats.  Fails unless +exp+ and +act+ are within +delta+
  # of each other.
  #
  #   assert_in_delta Math::PI, (22.0 / 7.0), 0.01
  #
  # source://minitest//lib/minitest/assertions.rb#196
  def assert_in_delta(exp, act, delta = T.unsafe(nil), msg = T.unsafe(nil)); end

  # For comparing Floats.  Fails unless +exp+ and +act+ have a relative
  # error less than +epsilon+.
  #
  # source://minitest//lib/minitest/assertions.rb#208
  def assert_in_epsilon(exp, act, epsilon = T.unsafe(nil), msg = T.unsafe(nil)); end

  # Fails unless +collection+ includes +obj+.
  #
  # source://minitest//lib/minitest/assertions.rb#215
  def assert_includes(collection, obj, msg = T.unsafe(nil)); end

  # Fails unless +obj+ is an instance of +cls+.
  #
  # source://minitest//lib/minitest/assertions.rb#226
  def assert_instance_of(cls, obj, msg = T.unsafe(nil)); end

  # Fails unless +obj+ is a kind of +cls+.
  #
  # source://minitest//lib/minitest/assertions.rb#237
  def assert_kind_of(cls, obj, msg = T.unsafe(nil)); end

  # Fails unless +matcher+ <tt>=~</tt> +obj+.
  #
  # source://minitest//lib/minitest/assertions.rb#247
  def assert_match(matcher, obj, msg = T.unsafe(nil)); end

  # Fails unless +obj+ is nil
  #
  # source://minitest//lib/minitest/assertions.rb#257
  def assert_nil(obj, msg = T.unsafe(nil)); end

  # For testing with binary operators. Eg:
  #
  #   assert_operator 5, :<=, 4
  #
  # source://minitest//lib/minitest/assertions.rb#267
  def assert_operator(o1, op, o2 = T.unsafe(nil), msg = T.unsafe(nil)); end

  # Fails if stdout or stderr do not output the expected results.
  # Pass in nil if you don't care about that streams output. Pass in
  # "" if you require it to be silent. Pass in a regexp if you want
  # to pattern match.
  #
  #   assert_output(/hey/) { method_with_output }
  #
  # NOTE: this uses #capture_io, not #capture_subprocess_io.
  #
  # See also: #assert_silent
  #
  # source://minitest//lib/minitest/assertions.rb#285
  def assert_output(stdout = T.unsafe(nil), stderr = T.unsafe(nil)); end

  # For testing with predicates. Eg:
  #
  #   assert_predicate str, :empty?
  #
  # This is really meant for specs and is front-ended by assert_operator:
  #
  #   str.must_be :empty?
  #
  # source://minitest//lib/minitest/assertions.rb#308
  def assert_predicate(o1, op, msg = T.unsafe(nil)); end

  # Fails unless the block raises one of +exp+. Returns the
  # exception matched so you can check the message, attributes, etc.
  #
  # +exp+ takes an optional message on the end to help explain
  # failures and defaults to StandardError if no exception class is
  # passed.
  #
  # source://minitest//lib/minitest/assertions.rb#321
  def assert_raises(*exp); end

  # Fails unless +obj+ responds to +meth+.
  #
  # source://minitest//lib/minitest/assertions.rb#349
  def assert_respond_to(obj, meth, msg = T.unsafe(nil)); end

  # Fails unless +exp+ and +act+ are #equal?
  #
  # source://minitest//lib/minitest/assertions.rb#359
  def assert_same(exp, act, msg = T.unsafe(nil)); end

  # +send_ary+ is a receiver, message and arguments.
  #
  # Fails unless the call returns a true value
  #
  # source://minitest//lib/minitest/assertions.rb#372
  def assert_send(send_ary, m = T.unsafe(nil)); end

  # Fails if the block outputs anything to stderr or stdout.
  #
  # See also: #assert_output
  #
  # source://minitest//lib/minitest/assertions.rb#388
  def assert_silent; end

  # Fails unless the block throws +sym+
  #
  # source://minitest//lib/minitest/assertions.rb#397
  def assert_throws(sym, msg = T.unsafe(nil)); end

  # Captures $stdout and $stderr into strings:
  #
  #   out, err = capture_io do
  #     puts "Some info"
  #     warn "You did a bad thing"
  #   end
  #
  #   assert_match %r%info%, out
  #   assert_match %r%bad%, err
  #
  # NOTE: For efficiency, this method uses StringIO and does not
  # capture IO for subprocesses. Use #capture_subprocess_io for
  # that.
  #
  # source://minitest//lib/minitest/assertions.rb#433
  def capture_io; end

  # Captures $stdout and $stderr into strings, using Tempfile to
  # ensure that subprocess IO is captured as well.
  #
  #   out, err = capture_subprocess_io do
  #     system "echo Some info"
  #     system "echo You did a bad thing 1>&2"
  #   end
  #
  #   assert_match %r%info%, out
  #   assert_match %r%bad%, err
  #
  # NOTE: This method is approximately 10x slower than #capture_io so
  # only use it when you need to test the output of a subprocess.
  #
  # source://minitest//lib/minitest/assertions.rb#466
  def capture_subprocess_io; end

  # Returns a diff between +exp+ and +act+. If there is no known
  # diff command or if it doesn't make sense to diff the output
  # (single line, short output), then it simply returns a basic
  # comparison between the two.
  #
  # source://minitest//lib/minitest/assertions.rb#59
  def diff(exp, act); end

  # Returns details for exception +e+
  #
  # source://minitest//lib/minitest/assertions.rb#495
  def exception_details(e, msg); end

  # Fails with +msg+
  #
  # source://minitest//lib/minitest/assertions.rb#509
  def flunk(msg = T.unsafe(nil)); end

  # Returns a proc that will output +msg+ along with the default message.
  #
  # source://minitest//lib/minitest/assertions.rb#517
  def message(msg = T.unsafe(nil), ending = T.unsafe(nil), &default); end

  # This returns a human-readable version of +obj+. By default
  # #inspect is called. You can override this to use #pretty_print
  # if you want.
  #
  # source://minitest//lib/minitest/assertions.rb#107
  def mu_pp(obj); end

  # This returns a diff-able human-readable version of +obj+. This
  # differs from the regular mu_pp because it expands escaped
  # newlines and makes hex-values generic (like object_ids). This
  # uses mu_pp to do the first pass and then cleans it up.
  #
  # source://minitest//lib/minitest/assertions.rb#127
  def mu_pp_for_diff(obj); end

  # used for counting assertions
  #
  # source://minitest//lib/minitest/assertions.rb#528
  def pass(_msg = T.unsafe(nil)); end

  # Fails if +test+ is truthy.
  #
  # source://minitest//lib/minitest/assertions.rb#535
  def refute(test, msg = T.unsafe(nil)); end

  # Fails if +obj+ is empty.
  #
  # source://minitest//lib/minitest/assertions.rb#543
  def refute_empty(obj, msg = T.unsafe(nil)); end

  # Fails if <tt>exp == act</tt>.
  #
  # For floats use refute_in_delta.
  #
  # source://minitest//lib/minitest/assertions.rb#554
  def refute_equal(exp, act, msg = T.unsafe(nil)); end

  # For comparing Floats.  Fails if +exp+ is within +delta+ of +act+.
  #
  #   refute_in_delta Math::PI, (22.0 / 7.0)
  #
  # source://minitest//lib/minitest/assertions.rb#566
  def refute_in_delta(exp, act, delta = T.unsafe(nil), msg = T.unsafe(nil)); end

  # For comparing Floats.  Fails if +exp+ and +act+ have a relative error
  # less than +epsilon+.
  #
  # source://minitest//lib/minitest/assertions.rb#578
  def refute_in_epsilon(a, b, epsilon = T.unsafe(nil), msg = T.unsafe(nil)); end

  # Fails if +collection+ includes +obj+.
  #
  # source://minitest//lib/minitest/assertions.rb#585
  def refute_includes(collection, obj, msg = T.unsafe(nil)); end

  # Fails if +obj+ is an instance of +cls+.
  #
  # source://minitest//lib/minitest/assertions.rb#596
  def refute_instance_of(cls, obj, msg = T.unsafe(nil)); end

  # Fails if +obj+ is a kind of +cls+.
  #
  # source://minitest//lib/minitest/assertions.rb#606
  def refute_kind_of(cls, obj, msg = T.unsafe(nil)); end

  # Fails if +matcher+ <tt>=~</tt> +obj+.
  #
  # source://minitest//lib/minitest/assertions.rb#614
  def refute_match(matcher, obj, msg = T.unsafe(nil)); end

  # Fails if +obj+ is nil.
  #
  # source://minitest//lib/minitest/assertions.rb#624
  def refute_nil(obj, msg = T.unsafe(nil)); end

  # Fails if +o1+ is not +op+ +o2+. Eg:
  #
  #   refute_operator 1, :>, 2 #=> pass
  #   refute_operator 1, :<, 2 #=> fail
  #
  # source://minitest//lib/minitest/assertions.rb#635
  def refute_operator(o1, op, o2 = T.unsafe(nil), msg = T.unsafe(nil)); end

  # For testing with predicates.
  #
  #   refute_predicate str, :empty?
  #
  # This is really meant for specs and is front-ended by refute_operator:
  #
  #   str.wont_be :empty?
  #
  # source://minitest//lib/minitest/assertions.rb#650
  def refute_predicate(o1, op, msg = T.unsafe(nil)); end

  # Fails if +obj+ responds to the message +meth+.
  #
  # source://minitest//lib/minitest/assertions.rb#658
  def refute_respond_to(obj, meth, msg = T.unsafe(nil)); end

  # Fails if +exp+ is the same (by object identity) as +act+.
  #
  # source://minitest//lib/minitest/assertions.rb#667
  def refute_same(exp, act, msg = T.unsafe(nil)); end

  # Skips the current run. If run in verbose-mode, the skipped run
  # gets listed at the end of the run but doesn't cause a failure
  # exit code.
  #
  # @raise [Minitest::Skip]
  #
  # source://minitest//lib/minitest/assertions.rb#680
  def skip(msg = T.unsafe(nil), bt = T.unsafe(nil)); end

  # Was this testcase skipped? Meant for #teardown.
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest/assertions.rb#689
  def skipped?; end

  class << self
    # Returns the diff command to use in #diff. Tries to intelligently
    # figure out what diff to use.
    #
    # source://minitest//lib/minitest/assertions.rb#29
    def diff; end

    # Set the diff command to use in #diff.
    #
    # source://minitest//lib/minitest/assertions.rb#49
    def diff=(o); end
  end
end

# source://minitest//lib/minitest/assertions.rb#157
Minitest::Assertions::E = T.let(T.unsafe(nil), String)

# source://minitest//lib/minitest/assertions.rb#19
Minitest::Assertions::UNDEFINED = T.let(T.unsafe(nil), Object)

# The standard backtrace filter for minitest.
#
# See Minitest.backtrace_filter=.
#
# source://minitest//lib/minitest.rb#937
class Minitest::BacktraceFilter
  # Filter +bt+ to something useful. Returns the whole thing if $DEBUG.
  #
  # source://minitest//lib/minitest.rb#944
  def filter(bt); end
end

# source://minitest//lib/minitest.rb#939
Minitest::BacktraceFilter::MT_RE = T.let(T.unsafe(nil), Regexp)

# Dispatch to multiple reporters as one.
#
# source://minitest//lib/minitest.rb#766
class Minitest::CompositeReporter < ::Minitest::AbstractReporter
  # @return [CompositeReporter] a new instance of CompositeReporter
  #
  # source://minitest//lib/minitest.rb#770
  def initialize(*reporters); end

  # Add another reporter to the mix.
  #
  # source://minitest//lib/minitest.rb#782
  def <<(reporter); end

  # source://minitest//lib/minitest.rb#775
  def io; end

  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#786
  def passed?; end

  # source://minitest//lib/minitest.rb#794
  def prerecord(klass, name); end

  # source://minitest//lib/minitest.rb#801
  def record(result); end

  # source://minitest//lib/minitest.rb#807
  def report; end

  # The list of reporters to dispatch to.
  #
  # source://minitest//lib/minitest.rb#768
  def reporters; end

  # The list of reporters to dispatch to.
  #
  # source://minitest//lib/minitest.rb#768
  def reporters=(_arg0); end

  # source://minitest//lib/minitest.rb#790
  def start; end
end

# source://minitest//lib/minitest.rb#12
Minitest::ENCS = T.let(T.unsafe(nil), TrueClass)

# Provides a simple set of guards that you can use in your tests
# to skip execution if it is not applicable. These methods are
# mixed into Test as both instance and class methods so you
# can use them inside or outside of the test methods.
#
#   def test_something_for_mri
#     skip "bug 1234"  if jruby?
#     # ...
#   end
#
#   if windows? then
#     # ... lots of test methods ...
#   end
#
# source://minitest//lib/minitest.rb#894
module Minitest::Guard
  # Is this running on jruby?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#899
  def jruby?(platform = T.unsafe(nil)); end

  # Is this running on maglev?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#906
  def maglev?(platform = T.unsafe(nil)); end

  # Is this running on mri?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#913
  def mri?(platform = T.unsafe(nil)); end

  # Is this running on rubinius?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#920
  def rubinius?(platform = T.unsafe(nil)); end

  # Is this running on windows?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#927
  def windows?(platform = T.unsafe(nil)); end
end

# source://minitest//lib/minitest/parallel.rb#2
module Minitest::Parallel; end

# The engine used to run multiple tests in parallel.
#
# source://minitest//lib/minitest/parallel.rb#7
class Minitest::Parallel::Executor
  # Create a parallel test executor of with +size+ workers.
  #
  # @return [Executor] a new instance of Executor
  #
  # source://minitest//lib/minitest/parallel.rb#17
  def initialize(size); end

  # Add a job to the queue
  #
  # source://minitest//lib/minitest/parallel.rb#43
  def <<(work); end

  # Shuts down the pool of workers by signalling them to quit and
  # waiting for them all to finish what they're currently working
  # on.
  #
  # source://minitest//lib/minitest/parallel.rb#50
  def shutdown; end

  # The size of the pool of workers.
  #
  # source://minitest//lib/minitest/parallel.rb#12
  def size; end

  # Start the executor
  #
  # source://minitest//lib/minitest/parallel.rb#26
  def start; end
end

# source://minitest//lib/minitest/parallel.rb#56
module Minitest::Parallel::Test
  # source://minitest//lib/minitest/parallel.rb#57
  def _synchronize; end
end

# source://minitest//lib/minitest/parallel.rb#59
module Minitest::Parallel::Test::ClassMethods
  # source://minitest//lib/minitest/parallel.rb#60
  def run_one_method(klass, method_name, reporter); end

  # source://minitest//lib/minitest/parallel.rb#64
  def test_order; end
end

# A very simple reporter that prints the "dots" during the run.
#
# This is added to the top-level CompositeReporter at the start of
# the run. If you want to change the output of minitest via a
# plugin, pull this out of the composite and replace it with your
# own.
#
# source://minitest//lib/minitest.rb#609
class Minitest::ProgressReporter < ::Minitest::Reporter
  # source://minitest//lib/minitest.rb#610
  def prerecord(klass, name); end

  # source://minitest//lib/minitest.rb#617
  def record(result); end
end

# Shared code for anything that can get passed to a Reporter. See
# Minitest::Test & Minitest::Result.
#
# source://minitest//lib/minitest.rb#443
module Minitest::Reportable
  # @raise [NotImplementedError]
  #
  # source://minitest//lib/minitest.rb#463
  def class_name; end

  # Did this run error?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#484
  def error?; end

  # The location identifier of this test. Depends on a method
  # existing called class_name.
  #
  # source://minitest//lib/minitest.rb#458
  def location; end

  # Did this run pass?
  #
  # Note: skipped runs are not considered passing, but they don't
  # cause the process to exit non-zero.
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#450
  def passed?; end

  # Returns ".", "F", or "E" based on the result of the run.
  #
  # source://minitest//lib/minitest.rb#470
  def result_code; end

  # Was this run skipped?
  #
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#477
  def skipped?; end
end

# source://minitest//lib/minitest.rb#585
class Minitest::Reporter < ::Minitest::AbstractReporter
  # @return [Reporter] a new instance of Reporter
  #
  # source://minitest//lib/minitest.rb#594
  def initialize(io = T.unsafe(nil), options = T.unsafe(nil)); end

  # The IO used to report.
  #
  # source://minitest//lib/minitest.rb#587
  def io; end

  # The IO used to report.
  #
  # source://minitest//lib/minitest.rb#587
  def io=(_arg0); end

  # Command-line options for this run.
  #
  # source://minitest//lib/minitest.rb#592
  def options; end

  # Command-line options for this run.
  #
  # source://minitest//lib/minitest.rb#592
  def options=(_arg0); end
end

# This represents a test result in a clean way that can be
# marshalled over a wire. Tests can do anything they want to the
# test instance and can create conditions that cause Marshal.dump to
# blow up. By using Result.from(a_test) you can be reasonably sure
# that the test result can be marshalled.
#
# source://minitest//lib/minitest.rb#496
class Minitest::Result < ::Minitest::Runnable
  include ::Minitest::Reportable

  # source://minitest//lib/minitest.rb#529
  def class_name; end

  # The class name of the test result.
  #
  # source://minitest//lib/minitest.rb#505
  def klass; end

  # The class name of the test result.
  #
  # source://minitest//lib/minitest.rb#505
  def klass=(_arg0); end

  # The location of the test method.
  #
  # source://minitest//lib/minitest.rb#510
  def source_location; end

  # The location of the test method.
  #
  # source://minitest//lib/minitest.rb#510
  def source_location=(_arg0); end

  # source://minitest//lib/minitest.rb#533
  def to_s; end

  class << self
    # Create a new test result from a Runnable instance.
    #
    # source://minitest//lib/minitest.rb#515
    def from(runnable); end
  end
end

# re-open
#
# source://minitest//lib/minitest.rb#246
class Minitest::Runnable
  # @return [Runnable] a new instance of Runnable
  #
  # source://minitest//lib/minitest.rb#400
  def initialize(name); end

  # Number of assertions executed in this run.
  #
  # source://minitest//lib/minitest.rb#250
  def assertions; end

  # Number of assertions executed in this run.
  #
  # source://minitest//lib/minitest.rb#250
  def assertions=(_arg0); end

  # source://minitest//lib/minitest.rb#396
  def failure; end

  # An assertion raised during the run, if any.
  #
  # source://minitest//lib/minitest.rb#255
  def failures; end

  # An assertion raised during the run, if any.
  #
  # source://minitest//lib/minitest.rb#255
  def failures=(_arg0); end

  # source://minitest//lib/minitest.rb#382
  def marshal_dump; end

  # source://minitest//lib/minitest.rb#392
  def marshal_load(ary); end

  # Name of the run.
  #
  # source://minitest//lib/minitest.rb#273
  def name; end

  # Set the name of the run.
  #
  # source://minitest//lib/minitest.rb#280
  def name=(o); end

  # Did this run pass?
  #
  # Note: skipped runs are not considered passing, but they don't
  # cause the process to exit non-zero.
  #
  # @raise [NotImplementedError]
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#419
  def passed?; end

  # Returns a single character string to print based on the result
  # of the run. Eg ".", "F", or "E".
  #
  # @raise [NotImplementedError]
  #
  # source://minitest//lib/minitest.rb#427
  def result_code; end

  # Runs a single method. Needs to return self.
  #
  # @raise [NotImplementedError]
  #
  # source://minitest//lib/minitest.rb#409
  def run; end

  # Was this run skipped? See #passed? for more information.
  #
  # @raise [NotImplementedError]
  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#434
  def skipped?; end

  # The time it took to run.
  #
  # source://minitest//lib/minitest.rb#260
  def time; end

  # The time it took to run.
  #
  # source://minitest//lib/minitest.rb#260
  def time=(_arg0); end

  # source://minitest//lib/minitest.rb#262
  def time_it; end

  class << self
    # source://minitest//lib/minitest.rb#978
    def inherited(klass); end

    # Returns all instance methods matching the pattern +re+.
    #
    # source://minitest//lib/minitest.rb#287
    def methods_matching(re); end

    # source://minitest//lib/minitest.rb#352
    def on_signal(name, action); end

    # source://minitest//lib/minitest.rb#291
    def reset; end

    # Responsible for running all runnable methods in a given class,
    # each in its own instance. Each instance is passed to the
    # reporter to record.
    #
    # source://minitest//lib/minitest.rb#302
    def run(reporter, options = T.unsafe(nil)); end

    # Runs a single method and has the reporter record the result.
    # This was considered internal API but is factored out of run so
    # that subclasses can specialize the running of an individual
    # test. See Minitest::ParallelTest::ClassMethods for an example.
    #
    # source://minitest//lib/minitest.rb#332
    def run_one_method(klass, method_name, reporter); end

    # Each subclass of Runnable is responsible for overriding this
    # method to return all runnable methods. See #methods_matching.
    #
    # @raise [NotImplementedError]
    #
    # source://minitest//lib/minitest.rb#369
    def runnable_methods; end

    # Returns all subclasses of Runnable.
    #
    # source://minitest//lib/minitest.rb#376
    def runnables; end

    # source://minitest//lib/minitest.rb#337
    def with_info_handler(reporter, &block); end
  end
end

# source://minitest//lib/minitest.rb#350
Minitest::Runnable::SIGNALS = T.let(T.unsafe(nil), Hash)

# Assertion raised when skipping a run.
#
# source://minitest//lib/minitest.rb#844
class Minitest::Skip < ::Minitest::Assertion
  # source://minitest//lib/minitest.rb#845
  def result_label; end
end

# A reporter that gathers statistics about a test run. Does not do
# any IO because meant to be used as a parent class for a reporter
# that does.
#
# If you want to create an entirely different type of output (eg,
# CI, HTML, etc), this is the place to start.
#
# source://minitest//lib/minitest.rb#633
class Minitest::StatisticsReporter < ::Minitest::Reporter
  # :startdoc:
  #
  # @return [StatisticsReporter] a new instance of StatisticsReporter
  #
  # source://minitest//lib/minitest.rb#644
  def initialize(io = T.unsafe(nil), options = T.unsafe(nil)); end

  # :stopdoc:
  #
  # source://minitest//lib/minitest.rb#634
  def assertions; end

  # :stopdoc:
  #
  # source://minitest//lib/minitest.rb#634
  def assertions=(_arg0); end

  # Returns the value of attribute count.
  #
  # source://minitest//lib/minitest.rb#635
  def count; end

  # Sets the attribute count
  #
  # @param value the value to set the attribute count to.
  #
  # source://minitest//lib/minitest.rb#635
  def count=(_arg0); end

  # Returns the value of attribute errors.
  #
  # source://minitest//lib/minitest.rb#640
  def errors; end

  # Sets the attribute errors
  #
  # @param value the value to set the attribute errors to.
  #
  # source://minitest//lib/minitest.rb#640
  def errors=(_arg0); end

  # Returns the value of attribute failures.
  #
  # source://minitest//lib/minitest.rb#639
  def failures; end

  # Sets the attribute failures
  #
  # @param value the value to set the attribute failures to.
  #
  # source://minitest//lib/minitest.rb#639
  def failures=(_arg0); end

  # @return [Boolean]
  #
  # source://minitest//lib/minitest.rb#657
  def passed?; end

  # source://minitest//lib/minitest.rb#665
  def record(result); end

  # source://minitest//lib/minitest.rb#672
  def report; end

  # Returns the value of attribute results.
  #
  # source://minitest//lib/minitest.rb#636
  def results; end

  # Sets the attribute results
  #
  # @param value the value to set the attribute results to.
  #
  # source://minitest//lib/minitest.rb#636
  def results=(_arg0); end

  # Returns the value of attribute skips.
  #
  # source://minitest//lib/minitest.rb#641
  def skips; end

  # Sets the attribute skips
  #
  # @param value the value to set the attribute skips to.
  #
  # source://minitest//lib/minitest.rb#641
  def skips=(_arg0); end

  # source://minitest//lib/minitest.rb#661
  def start; end

  # Returns the value of attribute start_time.
  #
  # source://minitest//lib/minitest.rb#637
  def start_time; end

  # Sets the attribute start_time
  #
  # @param value the value to set the attribute start_time to.
  #
  # source://minitest//lib/minitest.rb#637
  def start_time=(_arg0); end

  # Returns the value of attribute total_time.
  #
  # source://minitest//lib/minitest.rb#638
  def total_time; end

  # Sets the attribute total_time
  #
  # @param value the value to set the attribute total_time to.
  #
  # source://minitest//lib/minitest.rb#638
  def total_time=(_arg0); end
end

# A reporter that prints the header, summary, and failure details at
# the end of the run.
#
# This is added to the top-level CompositeReporter at the start of
# the run. If you want to change the output of minitest via a
# plugin, pull this out of the composite and replace it with your
# own.
#
# source://minitest//lib/minitest.rb#693
class Minitest::SummaryReporter < ::Minitest::StatisticsReporter
  # source://minitest//lib/minitest.rb#727
  def aggregated_results(io); end

  # Returns the value of attribute old_sync.
  #
  # source://minitest//lib/minitest.rb#695
  def old_sync; end

  # Sets the attribute old_sync
  #
  # @param value the value to set the attribute old_sync to.
  #
  # source://minitest//lib/minitest.rb#695
  def old_sync=(_arg0); end

  # source://minitest//lib/minitest.rb#710
  def report; end

  # :startdoc:
  #
  # source://minitest//lib/minitest.rb#698
  def start; end

  # source://minitest//lib/minitest.rb#722
  def statistics; end

  # source://minitest//lib/minitest.rb#742
  def summary; end

  # :stopdoc:
  #
  # source://minitest//lib/minitest.rb#694
  def sync; end

  # :stopdoc:
  #
  # source://minitest//lib/minitest.rb#694
  def sync=(_arg0); end

  # source://minitest//lib/minitest.rb#738
  def to_s; end

  private

  # source://minitest//lib/minitest.rb#755
  def binary_string; end
end

# Subclass Test to create your own tests. Typically you'll want a
# Test subclass per implementation class.
#
# See Minitest::Assertions
#
# source://minitest//lib/minitest/test.rb#10
class Minitest::Test < ::Minitest::Runnable
  include ::Minitest::Assertions
  include ::Minitest::Reportable
  include ::Minitest::Test::LifecycleHooks
  include ::Minitest::Guard
  extend ::Minitest::Guard

  # LifecycleHooks
  #
  # source://minitest//lib/minitest/test.rb#194
  def capture_exceptions; end

  # source://minitest//lib/minitest/test.rb#15
  def class_name; end

  # Runs a single test with setup/teardown hooks.
  #
  # source://minitest//lib/minitest/test.rb#92
  def run; end

  # source://minitest//lib/minitest/test.rb#204
  def with_info_handler(&block); end

  class << self
    # Call this at the top of your tests when you absolutely
    # positively need to have ordered tests. In doing so, you're
    # admitting that you suck and your tests are weak.
    #
    # source://minitest//lib/minitest/test.rb#31
    def i_suck_and_my_tests_are_order_dependent!; end

    # Returns the value of attribute io_lock.
    #
    # source://minitest//lib/minitest/test.rb#22
    def io_lock; end

    # Sets the attribute io_lock
    #
    # @param value the value to set the attribute io_lock to.
    #
    # source://minitest//lib/minitest/test.rb#22
    def io_lock=(_arg0); end

    # Make diffs for this Test use #pretty_inspect so that diff
    # in assert_equal can have more details. NOTE: this is much slower
    # than the regular inspect but much more usable for complex
    # objects.
    #
    # source://minitest//lib/minitest/test.rb#44
    def make_my_diffs_pretty!; end

    # Call this at the top of your tests when you want to run your
    # tests in parallel. In doing so, you're admitting that you rule
    # and your tests are awesome.
    #
    # source://minitest//lib/minitest/test.rb#55
    def parallelize_me!; end

    # Returns all instance methods starting with "test_". Based on
    # #test_order, the methods are either sorted, randomized
    # (default), or run in parallel.
    #
    # source://minitest//lib/minitest/test.rb#65
    def runnable_methods; end

    # Defines the order to run tests (:random by default). Override
    # this or use a convenience method to change it for your tests.
    #
    # source://minitest//lib/minitest/test.rb#83
    def test_order; end
  end
end

# Provides before/after hooks for setup and teardown. These are
# meant for library writers, NOT for regular test authors. See
# #before_setup for an example.
#
# source://minitest//lib/minitest/test.rb#117
module Minitest::Test::LifecycleHooks
  # Runs before every test, after setup. This hook is meant for
  # libraries to extend minitest. It is not meant to be used by
  # test developers.
  #
  # See #before_setup for an example.
  #
  # source://minitest//lib/minitest/test.rb#167
  def after_setup; end

  # Runs after every test, after teardown. This hook is meant for
  # libraries to extend minitest. It is not meant to be used by
  # test developers.
  #
  # See #before_setup for an example.
  #
  # source://minitest//lib/minitest/test.rb#191
  def after_teardown; end

  # Runs before every test, before setup. This hook is meant for
  # libraries to extend minitest. It is not meant to be used by
  # test developers.
  #
  # As a simplistic example:
  #
  #   module MyMinitestPlugin
  #     def before_setup
  #       super
  #       # ... stuff to do before setup is run
  #     end
  #
  #     def after_setup
  #       # ... stuff to do after setup is run
  #       super
  #     end
  #
  #     def before_teardown
  #       super
  #       # ... stuff to do before teardown is run
  #     end
  #
  #     def after_teardown
  #       # ... stuff to do after teardown is run
  #       super
  #     end
  #   end
  #
  #   class MiniTest::Test
  #     include MyMinitestPlugin
  #   end
  #
  # source://minitest//lib/minitest/test.rb#152
  def before_setup; end

  # Runs after every test, before teardown. This hook is meant for
  # libraries to extend minitest. It is not meant to be used by
  # test developers.
  #
  # See #before_setup for an example.
  #
  # source://minitest//lib/minitest/test.rb#176
  def before_teardown; end

  # Runs before every test. Use this to set up before each test
  # run.
  #
  # source://minitest//lib/minitest/test.rb#158
  def setup; end

  # Runs after every test. Use this to clean up after each test
  # run.
  #
  # source://minitest//lib/minitest/test.rb#182
  def teardown; end
end

# source://minitest//lib/minitest/test.rb#19
Minitest::Test::PASSTHROUGH_EXCEPTIONS = T.let(T.unsafe(nil), Array)

# source://minitest//lib/minitest/test.rb#87
Minitest::Test::TEARDOWN_METHODS = T.let(T.unsafe(nil), Array)

# Assertion wrapping an unexpected error that was raised during a run.
#
# source://minitest//lib/minitest.rb#853
class Minitest::UnexpectedError < ::Minitest::Assertion
  # @return [UnexpectedError] a new instance of UnexpectedError
  #
  # source://minitest//lib/minitest.rb#856
  def initialize(exception); end

  # source://minitest//lib/minitest.rb#861
  def backtrace; end

  # source://minitest//lib/minitest.rb#865
  def error; end

  # source://minitest//lib/minitest.rb#854
  def exception; end

  # source://minitest//lib/minitest.rb#854
  def exception=(_arg0); end

  # source://minitest//lib/minitest.rb#869
  def message; end

  # source://minitest//lib/minitest.rb#874
  def result_label; end
end

# source://minitest//lib/minitest/unit.rb#21
class Minitest::Unit
  class << self
    # source://minitest//lib/minitest/unit.rb#37
    def after_tests(&b); end

    # source://minitest//lib/minitest/unit.rb#31
    def autorun; end
  end
end

# source://minitest//lib/minitest/unit.rb#23
class Minitest::Unit::TestCase < ::Minitest::Test
  class << self
    # source://minitest//lib/minitest/unit.rb#24
    def inherited(klass); end
  end
end

# source://minitest//lib/minitest/unit.rb#22
Minitest::Unit::VERSION = T.let(T.unsafe(nil), String)

# source://minitest//lib/minitest.rb#11
Minitest::VERSION = T.let(T.unsafe(nil), String)