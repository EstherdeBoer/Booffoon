require 'active_model'

class Article
  include ::ActiveModel::Model
  attr_accessor :title, :body
end
