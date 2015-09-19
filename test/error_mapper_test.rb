require "test_helper"
require "ostruct"
require "booffoon/error_mapper"

module Booffoon
class ErrorMapperTest < ActionView::TestCase
  test "maps errors from belongs_to association" do
    article = articles(:sturgeon)
    article.errors.add(:category_id, :blank)
    article.errors.add(:category, :required)
    assert_equal "category", ErrorMapper.new(article, :category_id).association_name
    assert_equal ["can't be blank", "must exist"], ErrorMapper.new(article, :category_id).errors
  end

  test "maps errors for has_many association" do
    subject = article_categories(:quotes)
    subject.errors.add(:article_ids, :blank)
    subject.errors.add(:articles,    :required)
    assert_equal "articles", ErrorMapper.new(subject, :article_ids).association_name
    assert_equal ["can't be blank", "must exist"], ErrorMapper.new(subject, :article_ids).errors
  end

  test "does not mapp when not association" do
    subject = articles(:sturgeon)
    class << subject
      attr_accessor :foo_id, :foo
    end
    subject.errors.add(:foo_id, :blank)
    subject.errors.add(:foo, :required)
    assert_equal nil, ErrorMapper.new(subject, :foo_id).association_name
    assert_equal ["can't be blank"], ErrorMapper.new(subject, :foo_id).errors
  end

  test "no errors edge case" do
    subject = article_categories(:quotes)
    assert_equal "articles", ErrorMapper.new(subject, :article_ids).association_name
    assert_equal [], ErrorMapper.new(subject, :article_ids).errors
  end
end
end
