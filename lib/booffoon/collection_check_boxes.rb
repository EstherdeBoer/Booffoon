module Booffoon
module CollectionCheckBoxes
  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    if block_given?
      super
    else
      super(method, collection, value_method, text_method, options, html_options) do |builder|
        content_tag(:div, class: "checkbox") do
          builder.label("class": "") do
            concat builder.check_box
            concat builder.text
          end
        end
      end
    end
  end

  def collection_check_boxes_inline(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}) do |builder|
      builder.label("class": "checkbox-inline") do
        concat builder.check_box
        concat builder.text
      end
    end
  end
end
end
