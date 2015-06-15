module Booffoon
class BuilderWithMain < Builder
  def wrapper(field_name, hint_text: nil, label_text: nil, &block)
    wrapper_tag(field_name) do
      concat label(field_name, label_text)
      concat (main_wrapper_tag do
        concat @template.capture(&block)
        concat errors(field_name)
        concat hint(field_name, hint_text)
      end)
    end
  end

  def main_wrapper_tag(&block)
    content_tag(:div, class: "main", &block)
  end
end
end

