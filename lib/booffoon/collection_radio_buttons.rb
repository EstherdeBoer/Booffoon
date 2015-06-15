module Booffoon
module CollectionRadioButtons
  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {})
    if block_given?
      super
    else
      super(method, collection, value_method, text_method, options, html_options) do |builder|
        content_tag(:div, class: "radio") do
          builder.label("class": "") do
            concat builder.radio_button
            concat builder.text
          end
        end
      end
    end
  end

  def collection_radio_buttons_inline(method, collection, value_method, text_method, options = {}, html_options = {})
    collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {}) do |builder|
      builder.label("class": "radio-inline") do
        concat builder.radio_button
        concat builder.text
      end
    end
  end
end
end
