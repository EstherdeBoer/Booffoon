require 'test_helper'

module Booffoon
class InputsTest < ActionView::TestCase
  self.helper_class = Booffoon # so as not to automatically mix-in Booffoon Inputs into test/template

  test "collection_check_boxes" do
    concat (form_for(articles(:sturgeon), builder: Builder) do |form|
      concat form.collection_check_boxes(:category_id, Category.all, :id, :name)
    end)
    assert_select "label.checkbox", text: "Quotes" do
      assert_select "input[type=checkbox][value='#{categories(:quotes).id}'][checked]"
    end
  end
end
end
