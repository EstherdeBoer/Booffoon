require 'test_helper'

module Booffoon
class CollectionRadioButtonsTest < ActionView::TestCase
  self.helper_class = Booffoon # so as not to automatically mix-in Booffoon Inputs into test/template

  test "collection_radio_buttons" do
    concat (form_for(articles(:sturgeon), builder: Builder) do |form|
      concat form.collection_radio_buttons(:category_id, Category.all, :id, :name)
    end)
    assert_select("div.radio") do
      assert_select("label", text: "Quotes") do
        assert_select "input[type=radio][value='#{categories(:quotes).id}'][checked]"
      end
    end
  end

  test "collection_radio_buttons with custom block" do
    concat (fields_for(:article, articles(:sturgeon), builder: Builder) do |form|
      concat (form.collection_radio_buttons(:category_id, Category.all, :id, :name) do |builder|
        builder.label("class": "custom") do
          concat builder.radio_button
          concat builder.text
        end
      end)
    end)
    assert_select("label.custom", text: "Quotes") do
      assert_select "input"
    end
  end

  test "collection_radio_buttons inline" do
    concat (fields_for(:article, articles(:sturgeon), builder: Builder) do |form|
      concat form.collection_radio_buttons_inline(:category_id, Category.all, :id, :name)
    end)
    assert_select("label.radio-inline", text: "Quotes") do
      assert_select "input"
    end
  end
end
end
