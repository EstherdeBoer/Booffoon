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

  test "collection_radio_buttons with disabled item" do
    disabled = OpenStruct.new(id: 1, name: "Disabled", disabled?: true)
    enabled  = OpenStruct.new(id: 2, name: "Enabled",  disabled?: false)
    default  = Category.new(id: 3, name: "Default")

    concat (fields_for(:article, articles(:sturgeon), builder: Builder) do |form|
      concat (form.collection_radio_buttons(:category_id, [enabled, disabled, default], :id, :name))
    end)
    assert_select "input[value='1'][disabled]"
    assert_select "input[value='2']:not([disabled])"
    assert_select "input[value='3']:not([disabled])"
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
