module Booffoon
class Builder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :concat, to: :@template

  AUTO = :auto

  def wrapper(field_name, hint: AUTO, label: nil, label_class: "control-label", &block)
    content_tag(:div, class: wrapper_classes(field_name).join(" ")) do
      concat self.label(field_name, label, class: label_class)
      concat @template.capture(&block)
      concat errors(field_name)
      concat self.hint(field_name, hint)
    end
  end

  def errors(field_name)
    if (messages = object.errors.messages[field_name]).present?
      content_tag(:span, " " + messages.join(" "), class: "error help-block")
    end
  end

  def hint(field_name, hint)
    model_key = object.class.model_name.singular
    if hint == AUTO
      hint = @template.t("hints.#{model_key}.#{field_name}", default: "", raise: false)
    end
    if hint.present?
      content_tag(:p, " " + hint, class: "help-block")
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

  def options_select(method, options_collection, options: {}, html_options: {})
    collection_select(method, options_collection, :value, :label, options, html_options.reverse_merge(class: "form-control"))
  end

  %w[text_field text_area phone_field number_field url_field password_field email_field date_field].each do |method_name|
    define_method(method_name) do |method, options = {}|
      super(method, options.reverse_merge(class: "form-control"))
    end
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    super(method, choices, options, html_options.reverse_merge(class: "form-control"), &block)
  end

  def collection_select(method, collection, value_method, text_method, options: {}, html_options: {})
    super(method, collection, value_method, text_method, options, html_options.reverse_merge(class: "form-control"))
  end
end
end
