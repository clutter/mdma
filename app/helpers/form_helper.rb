# typed: true
# Methods related to visualizing forms
module FormHelper
  def fieldset(legend, &block)
    fieldset = safe_join [tag.legend("#{legend}:"), capture(&block)]
    safe_join [tag.hr, fieldset]
  end

  def with_errors_on(model, *attributes)
    attributes_with_errors = model.errors.keys & attributes

    if attributes_with_errors.any?
      yield(class: 'form-control is-invalid')
      errors = attributes.flat_map { |attribute| model.errors.full_messages_for(attribute) }
      concat tag.div(errors.to_sentence, class: 'invalid-feedback')
    else
      yield(class: 'form-control')
    end
  end
end
