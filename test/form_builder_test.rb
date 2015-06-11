require 'test_helper'

class FormBuilderTest < ActionView::TestCase
  test "builds form" do
    article = Article.new(title: "World Peace")
    concat (form_for(article, builder: Booffoon::Builder) do |form|
      concat form.text_field(:title)
    end)
    assert_select "form"
  end
end
