require 'test_helper'

class WrappedFieldsTest < ActionView::TestCase
  test "passes wrapper and input options" do
    concat (form_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.wrapped_text_field(:title, label_text: "Custom label", "class": "biggish")
    end)
    assert_select("div.form-group") do
      assert_select "label", text: "Custom label"
      assert_select "input.biggish"
    end
  end
end
