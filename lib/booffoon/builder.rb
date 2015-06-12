module Booffoon
class Builder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :concat, :t, to: :@template

  TRANSLATE = :translate

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
    if hint == TRANSLATE
      hint = t("hints.#{model_key}.#{field_name}", default: "", raise: false)
    end
    if hint.present?
      content_tag(:p, " " + hint, class: "help-block")
    end
  end

  def label(field_name, text = nil, options = {}, &block)
    model_key = object.class.model_name.singular
    if text == TRANSLATE
      text = t(field_name, scope: [:labels, model_key])
    end
    super(field_name, text, options, &block)
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
    define_method(method_name) do |attr, options = {}|
      super(attr, options.reverse_merge(class: "form-control"))
    end

    define_method("wrapped_#{method_name}") do |*args|
      wrapper(args.first) do
        public_send(method_name, *args)
      end
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
