require 'test_helper'

module Booffoon
class CollectionCheckBoxesTest < ActionView::TestCase
  self.helper_class = Booffoon # so as not to automatically mix-in Booffoon Inputs into test/template

  test "collection_check_boxes" do
    concat (form_for(articles(:sturgeon), builder: Builder) do |form|
      concat form.collection_check_boxes(:category_id, Article::Category.all, :id, :name)
    end)
    assert_select("div.checkbox") do
      assert_select("label", text: "Quotes") do
        assert_select "input[type=checkbox][value='#{article_categories(:quotes).id}'][checked]"
      end
    end
  end

  test "collection_check_boxes with custom block" do
    concat (fields_for(:article, articles(:sturgeon), builder: Builder) do |form|
      concat (form.collection_check_boxes(:category_id, Article::Category.all, :id, :name) do |builder|
        builder.label("class": "custom") do
          concat builder.check_box
          concat builder.text
        end
      end)
    end)
    assert_select("label.custom", text: "Quotes") do
      assert_select "input"
    end
  end

  test "collection_check_boxes inline" do
    concat (fields_for(:article, articles(:sturgeon), builder: Builder) do |form|
      concat form.collection_check_boxes_inline(:category_id, Article::Category.all, :id, :name)
    end)
    assert_select("label.checkbox-inline", text: "Quotes") do
      assert_select "input"
    end
  end
end
end
