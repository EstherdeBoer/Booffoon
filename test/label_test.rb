require 'test_helper'

class LabelTest < ActionView::TestCase
  test "accepts label content" do
    fields_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      assert_dom_equal %q#<label for="article_title">Custom</label>#, form.label(:title, "Custom")
    end
  end

  test "fetches label from translations" do
    concat (fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
      form.label(:title, :translate)
    end)
    assert_dom_equal %q#<label for="article_title">The title</label>#, view.output_buffer
  end

  test "raises on missing translations" do
    assert_raises(I18n::MissingTranslationData) do
      ActionView::Base.stub(:raise_on_missing_translations, true) do
        fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
          form.label(:body, :translate)
        end
      end
    end
  end

  test "falls back to auto-generated label" do
    concat (fields_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      form.label(:body)
    end)
    assert_dom_equal %q#<label for="article_body">Body</label>#, view.output_buffer
  end
end
