require 'test_helper'

module Booffoon
class ErrorsTest < ActionView::TestCase
  test "no error" do
    concat (fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.errors(:body)
    end)

    assert_equal "", view.output_buffer
  end

  test "custom class" do
    article = articles(:sturgeon)
    article.errors.add(:title, :required)
    concat (fields_for(:article, article, builder: Booffoon::Builder) do |form|
      concat form.errors(:title, class: "pretty-error")
    end)

    assert_select ".pretty-error", text: "must exist"
  end

  test "error" do
    article = articles(:sturgeon)
    article.errors.add(:title, :required)
    concat (fields_for(:article, article, builder: Booffoon::Builder) do |form|
      concat form.errors(:title)
    end)

    assert_select ".error", text: "must exist"
  end
end
end
