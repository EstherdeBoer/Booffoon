require 'test_helper'

class WrapperTest < ActionView::TestCase
  test "defaults" do
    concat (form_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.wrapper(:title) { content_tag(:p, "xxx") }
    end)
    assert_select("div.form-group") do
      assert_select "label", text: "Title"
      assert_select "p", text: "xxx"
    end
  end

  test "custom label" do
    concat (form_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.wrapper(:title, label: "Custom label") { "xxx" }
    end)
    assert_select "label", text: "Custom label"
  end

  test "custom hint" do
    concat (form_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat form.wrapper(:title, hint: "This is title") { "xxx" }
    end)
    assert_select "p.help-block", text: "This is title"
  end
end
