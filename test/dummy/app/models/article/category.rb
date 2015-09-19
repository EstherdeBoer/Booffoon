class Article::Category < ActiveRecord::Base
  has_many :articles, class_name: "::Article"
end
