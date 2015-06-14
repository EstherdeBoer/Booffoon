module Booffoon
module Inputs
  INPUT_CLASS = "form-control"

  %w[text_field text_area phone_field number_field url_field password_field email_field date_field].each do |method_name|
    define_method(method_name) do |attr, options = {}|
      super(attr, options.reverse_merge("class": INPUT_CLASS))
    end

    define_method("wrapped_#{method_name}") do |attr_name, label_text: nil, hint_text: nil, **input_options|
      wrapper(attr_name, label_text: label_text, hint_text: hint_text) do
        public_send(method_name, attr_name, input_options)
      end
    end
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    super(method, choices, options, html_options.reverse_merge("class": INPUT_CLASS), &block)
  end

  def collection_select(attr, collection, value_method, text_method, options: {}, html_options: {})
    super(attr, collection, value_method, text_method, options, html_options.reverse_merge("class": INPUT_CLASS))
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    super(method, collection, value_method, text_method, options, html_options) do |b|
      b.label(class: "checkbox") do
        concat b.check_box
        concat b.text
      end
    end
  end

  # def options_select(method, options = {}, html_options = {})
  #   collection_select(method, options, :value, :label, options, html_options.reverse_merge("class": INPUT_CLASS))
  # end
end
end
