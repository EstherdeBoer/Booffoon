require 'test_helper'

module Booffoon
class HintTest < ActionView::TestCase
  test "no hint" do
    concat (fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.hint(:body)
    end)

    assert_equal "", view.output_buffer
  end

  test "translated hint" do
    concat (fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.hint(:title)
    end)

    assert_select "p.hint.help-block", text: "Come up with some nice title here"
  end
end
end
