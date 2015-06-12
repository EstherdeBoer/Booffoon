require 'test_helper'

module Booffoon
class InputsTest < ActionView::TestCase
  self.helper_class = Booffoon # so as not to automatically mix-in Booffoon Inputs into test/template

  setup do
    @article = Article.new(title: "World Peace", category_id: 2)
    @categories = [Category.new(id: 1, name: "One"), Category.new(id: 2, name: "Two")]
  end

  test "collection_check_boxes" do
    concat (form_for(@article, builder: Builder) do |form|
      concat form.collection_check_boxes(:category_id, @categories, :id, :name)
    end)
    assert_select "label.checkbox", text: "Two" do
      assert_select "input[type=checkbox][value=2][checked=checked]"
    end
  end
end
end
