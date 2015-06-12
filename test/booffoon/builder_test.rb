require 'test_helper'

class FormBuilderTest < ActionView::TestCase
  setup do
    @article = Article.new(title: "World Peace")
  end

  test "adds form-control class to input" do
    concat (form_for(@article, builder: Booffoon::Builder) do |form|
      form.text_field(:title)
    end)

    assert_select("input.form-control")
  end

  test "adds form-group and form-control classes" do
    concat (form_for(@article, builder: Booffoon::Builder) do |form|
      concat (form.wrapper(:title) do
        concat form.text_field(:title)
      end)
    end)

    assert_select("div.form-group") do
      assert_select("input")
    end
  end

  test "automagic wrapped_field" do
    concat (form_for(@article, builder: Booffoon::Builder) do |form|
      concat form.wrapped_text_field(:title)
    end)

    assert_select("div.form-group") do
      assert_select("label", text: "Title")
      assert_select("input.form-control[type=text][name='article[title]']")
    end
  end
end
