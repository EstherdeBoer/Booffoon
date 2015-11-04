require "booffoon/inputs"
require "booffoon/errors"
require "booffoon/error_mapper"
require "booffoon/collection_check_boxes"
require "booffoon/collection_radio_buttons"

module Booffoon
class Builder < ActionView::Helpers::FormBuilder
  include Inputs
  include Errors
  include CollectionCheckBoxes
  include CollectionRadioButtons

  LABEL_CLASS = "control-label"
  HINT_CLASS  = "help-block hint"

  delegate :content_tag, :concat, :capture, :t, to: :@template

  def wrapper(field_name, hint_text: nil, label_text: nil, **html_options, &block)
    wrapper_tag(field_name, html_options) do
      concat label(field_name, label_text)
      concat @template.capture(&block)
      concat errors(field_name)
      concat hint(field_name, hint_text)
    end
  end

  def label(field_name, text = nil, options={})
    super(field_name, text, options.reverse_merge(class: LABEL_CLASS))
  end

  def wrapper_tag(field_name, html_options = {}, &block)
    css_classes = wrapper_classes(field_name).join(" ")
    html_options = {class: css_classes}.merge(html_options)
    content_tag(:div, html_options, &block)
  end

  def hint(field_name, text = nil)
    if text.nil?
      text = t(field_name, default: "", raise: false, scope: [:helpers, :hint, object.model_name.i18n_key])
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

  def submit(value=nil, options={})
    super(value, options.reverse_merge("class": "btn btn-primary"))
  end
end
end
