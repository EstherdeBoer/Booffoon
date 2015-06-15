require "booffoon/inputs"
require "booffoon/errors"
require "booffoon/error_mapper"

module Booffoon
class Builder < ActionView::Helpers::FormBuilder
  include Inputs
  include Errors

  LABEL_CLASS = "control-label"
  HINT_CLASS  = "help-block hint"

  delegate :content_tag, :concat, :t, to: :@template

  def wrapper(field_name, hint_text: nil, label_text: nil, &block)
    wrapper_tag(field_name) do
      concat label(field_name, label_text)
      concat @template.capture(&block)
      concat errors(field_name)
      concat hint(field_name, hint_text)
    end
  end

  def label(field_name, text = nil, options={})
    super(field_name, text, options.reverse_merge(class: LABEL_CLASS))
  end

  def wrapper_tag(field_name, &block)
    content_tag(:div, class: wrapper_classes(field_name).join(" "), &block)
  end

  def hint(field_name, text = nil)
    model_key = object.class.model_name.singular
    if text.nil?
      text = t(field_name, default: "", raise: false, scope: [:helpers, :hint, model_key])
    end
    if text.present?
      " ".html_safe + content_tag(:p, text, "class": HINT_CLASS)
    end
  end

  def wrapper_classes(field_name)
    wrapper_classes = ["form-group"]
    wrapper_classes << "has-error" if has_error_on?(field_name)
    wrapper_classes
  end

end
end
