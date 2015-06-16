require 'test_helper'

module Booffoon

class BuilderWithMainTest < ActionView::TestCase
  class BuilderWithMain < Builder
    def wrapper(field_name, hint_text: nil, label_text: nil, &block)
      wrapper_tag(field_name) do
        concat label(field_name, label_text)
        concat (main_wrapper_tag do
          concat capture(&block)
          concat errors(field_name)
          concat hint(field_name, hint_text)
        end)
      end
    end

    def main_wrapper_tag(&block)
      content_tag(:div, class: "main", &block)
    end
  end

  test "input with wrapper" do
    article = articles(:sturgeon)
    article.errors.add(:title, :required)
    concat (fields_for(:article, article, builder: BuilderWithMain) do |form|
      form.wrapper(:title) do
        form.text_field(:title)
      end
    end)

    assert_select("div.form-group > label")
    assert_select("div.form-group > div.main") do
      assert_select("input")
      assert_select(".error")
      assert_select(".help-block.hint")
    end
  end
end

end
