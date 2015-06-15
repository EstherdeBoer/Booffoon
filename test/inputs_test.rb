require 'test_helper'

module Booffoon
class InputsTest < ActionView::TestCase
  self.helper_class = Booffoon # so as not to automatically mix-in Booffoon Inputs into test/template

  test "adds form-control class to input" do
    concat (form_for(articles(:sturgeon), builder: Booffoon::Builder) do |form|
      form.text_field(:title)
    end)

    assert_select("input.form-control")
  end
end
end
