# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `sorbet-coerce` gem.
# Please instead update this file by running `bin/tapioca gem sorbet-coerce`.

# source://sorbet-coerce//lib/sorbet-coerce/configuration.rb#4
module TypeCoerce
  class << self
    # source://sorbet-coerce//lib/sorbet-coerce.rb#5
    def [](type); end
  end
end

# source://sorbet-coerce//lib/sorbet-coerce/converter.rb#11
class TypeCoerce::CoercionError < ::SafeType::CoercionError; end

# source://sorbet-coerce//lib/sorbet-coerce/configuration.rb#5
module TypeCoerce::Configuration
  class << self
    # source://sorbet-coerce//lib/sorbet-coerce/configuration.rb#10
    sig { returns(T::Boolean) }
    def raise_coercion_error; end

    # @return [Boolean]
    #
    # source://sorbet-coerce//lib/sorbet-coerce/configuration.rb#10
    def raise_coercion_error=(_arg0); end
  end
end

# source://sorbet-coerce//lib/sorbet-coerce/converter.rb#15
class TypeCoerce::Converter
  # @return [Converter] a new instance of Converter
  #
  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#16
  def initialize(type); end

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#28
  def from(args, raise_coercion_error: T.unsafe(nil)); end

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#20
  def new; end

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#24
  def to_s; end

  private

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#148
  def _build_args(args, type, raise_coercion_error); end

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#48
  def _convert(value, type, raise_coercion_error); end

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#110
  def _convert_simple(value, type, raise_coercion_error); end

  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#138
  def _convert_to_a(ary, type, raise_coercion_error); end

  # @return [Boolean]
  #
  # source://sorbet-coerce//lib/sorbet-coerce/converter.rb#166
  def _nil_like?(value, type); end
end

# source://sorbet-coerce//lib/sorbet-coerce/converter.rb#38
TypeCoerce::Converter::PRIMITIVE_TYPES = T.let(T.unsafe(nil), Set)

# source://sorbet-coerce//lib/sorbet-coerce/converter.rb#12
class TypeCoerce::ShapeError < ::SafeType::CoercionError; end
