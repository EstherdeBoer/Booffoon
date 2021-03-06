module Booffoon
module Inputs
  %w[text_field text_area phone_field number_field url_field password_field email_field date_field].each do |method_name|
    define_method(method_name) do |attr, options = {}|
      super(attr, options.reverse_merge("class": input_class(method_name)))
    end

    define_method("wrapped_#{method_name}") do |attr_name, label_text: nil, hint_text: nil, **input_options|
      wrapper(attr_name, label_text: label_text, hint_text: hint_text) do
        public_send(method_name, attr_name, input_options)
      end
    end
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    super(method, choices, options, html_options.reverse_merge("class": input_class("select")), &block)
  end

  def collection_select(attr, collection, value_method, text_method, options = {}, html_options = {}, &block)
    super(attr, collection, value_method, text_method, options, html_options.reverse_merge("class": input_class("select")), &block)
  end

  private

  def input_class(input_type)
    "form-control"
  end
end
end
