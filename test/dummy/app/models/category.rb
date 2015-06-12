require 'active_model'

class Category
  include ::ActiveModel::Model
  attr_accessor :id, :name
end
