class Article < ActiveRecord::Base
  belongs_to :category, class_name: "Article::Category"
end
