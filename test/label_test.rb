require 'test_helper'

class LabelTest < ActionView::TestCase
  setup do
    @article = Article.new(title: "World Peace")
  end

  test "accepts label content" do
    fields_for(@article, builder: Booffoon::Builder) do |form|
      assert_dom_equal %q#<label for="article_title">Custom</label>#, form.label(:title, "Custom")
    end
  end

  test "fetches label from translations" do
    concat (fields_for(:article, @article, builder: Booffoon::Builder) do |form|
      form.label(:title, :translate)
    end)
    assert_dom_equal %q#<label for="article_title">The title</label>#, view.output_buffer
  end

  test "falls back to auto-generated label" do
    concat (fields_for(@article, builder: Booffoon::Builder) do |form|
      form.label(:body)
    end)
    assert_dom_equal %q#<label for="article_body">Body</label>#, view.output_buffer
  end
end
