# Methods related to visualizing forms
module FormHelper
  def fieldset(legend, &block)
    fieldset = safe_join [tag.legend("#{legend}:"), capture(&block)]
    safe_join [tag.hr, fieldset]
  end
end
