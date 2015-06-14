require "booffoon/inputs"

module Booffoon
class Builder < ActionView::Helpers::FormBuilder
  include Inputs

  LABEL_CLASS="control-label"
  TRANSLATE = :translate

  delegate :content_tag, :concat, :t, to: :@template

  def wrapper(field_name, hint: nil, label: nil, &block)
    wrapper_tag(field_name) do
      concat self.label(field_name, label)
      concat @template.capture(&block)
      concat errors(field_name)
      concat self.hint(field_name, hint)
    end
  end

  def label(field_name, text = nil, options={})
    super(field_name, text, options.reverse_merge(class: LABEL_CLASS))
  end

  def wrapper_tag(field_name, &block)
    content_tag(:div, class: wrapper_classes(field_name).join(" "), &block)
  end

  def errors(field_name)
    if (messages = object.errors.messages[field_name]).present?
      content_tag(:span, " " + messages.join(" "), "class": "error help-block")
    end
  end

  def hint(field_name, hint = TRANSLATE)
    model_key = object.class.model_name.singular
    if hint == TRANSLATE
      hint = t("hints.#{model_key}.#{field_name}", default: "", raise: false)
    end
    if hint.present?
      content_tag(:p, " " + hint, "class": "help-block hint")
    end
  end

  def wrapper_classes(field_name)
    wrapper_classes = ["form-group"]
    wrapper_classes << "has-error" if has_error?(field_name)
    wrapper_classes
  end

  def has_error?(field_name)
    object.errors.messages[field_name.to_sym].present?
  end
end
end
