require 'test_helper'

module Booffoon
class FormBuilderTest < ActionView::TestCase
  test "input with wrapper" do
    article = articles(:sturgeon)
    article.errors.add(:title, :required)

    concat (fields_for(:article, article, builder: Booffoon::Builder) do |form|
      form.wrapper(:title, hint: :translate) do
        form.text_field(:title)
      end
    end)

    assert_select("div.form-group") do
      assert_select("input#article_title.form-control")
      assert_select("label.control-label[for=article_title]", text: "The title")
      assert_select(".error.help-block", text: "must exist")
      assert_select(".help-block.hint",  text: "Come up with some nice title here")
    end
  end

  test "equivalent with manually calling components" do
    concat (fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat (form.wrapper_tag(:title) do
        concat form.label(:title)
        concat form.text_field(:title)
        concat form.errors(:title)
        concat form.hint(:title, :translate)
      end)
    end)

    assert_select("div.form-group") do
      assert_select("input#article_title.form-control")
      assert_select("label.control-label[for=article_title]", text: "The title")
      assert_select(".help-block.hint",  text: "Come up with some nice title here")
    end
  end

  skip "use individual components without wrapper"
end
end
