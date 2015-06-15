require 'test_helper'

module Booffoon
class FormBuilderTest < ActionView::TestCase
  class DummyModel
    include ActiveModel::Model
    attr_accessor :title
  end

  test "input with wrapper" do
    article = articles(:sturgeon)
    article.errors.add(:title, :required)

    concat (fields_for(:article, article, builder: Booffoon::Builder) do |form|
      form.wrapper(:title) do
        form.text_field(:title)
      end
    end)

    assert_select("div.form-group") do
      assert_select("input#article_title.form-control")
      assert_select("label.control-label[for=article_title]", text: "The title")
      assert_select(".error.help-block", text: "must exist")
      assert_select(".help-block.hint",  text: "Come up with some nice title here")
    end
  end

  test "equivalent with manually calling components" do
    concat (fields_for(:article, articles(:sturgeon), builder: Booffoon::Builder) do |form|
      concat (form.wrapper_tag(:title) do
        concat form.label(:title)
        concat form.text_field(:title)
        concat form.errors(:title)
        concat form.hint(:title)
      end)
    end)

    assert_select("div.form-group") do
      assert_select("input#article_title.form-control")
      assert_select("label.control-label[for=article_title]", text: "The title")
      assert_select(".help-block.hint",  text: "Come up with some nice title here")
    end
  end

  test "maps error for association field" do
    article = articles(:sturgeon)
    # Note error added to category, not category_id. Validations are usually on association directly,
    # not on _id/_ids attributes.
    article.errors.add(:category, :required)

    concat (fields_for(:article, article, builder: Booffoon::Builder) do |form|
      form.wrapper(:category_id) do
        form.collection_select(:category_id, Category.all, :id, :name)
      end
    end)

    assert_select(".form-group.has-error") do
      assert_select ".error", text: "must exist"
    end
  end

  test "ActiveModel object" do
    model = DummyModel.new
    concat (fields_for(:dummy_model, model, builder: Booffoon::Builder) do |form|
      form.wrapper(:title) do
        form.text_field(:title)
      end
    end)
  
    assert_select("div.form-group") do
      assert_select("input")
      assert_select("label")
    end
  end

end
end
