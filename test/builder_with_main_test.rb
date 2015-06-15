require 'test_helper'

module Booffoon
class BuilderWithMainTest < ActionView::TestCase
  test "input with wrapper" do
    article = articles(:sturgeon)
    article.errors.add(:title, :required)
    concat (fields_for(:article, article, builder: Booffoon::BuilderWithMain) do |form|
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
