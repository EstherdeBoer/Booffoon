require 'test_helper'

class WrappedFieldsTest < ActionView::TestCase
  setup do
    @article = Article.new(title: "World Peace")
  end

  test "passes wrapper options" do
    concat (form_for(@article, builder: Booffoon::Builder) do |form|
      concat form.wrapped_text_field(:title, {label: "Custom label"})
    end)
    assert_select("div.form-group") do
      assert_select "label", text: "Custom label"
    end
  end

  test "passes input options" do
    concat (form_for(@article, builder: Booffoon::Builder) do |form|
      concat form.wrapped_text_field(:title, {}, "class": "biggish")
    end)
    assert_select("div.form-group") do
      assert_select "input.biggish"
    end
  end
end
