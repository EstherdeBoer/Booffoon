class PrefixCategories < ActiveRecord::Migration
  def change
    rename_table :categories, :article_categories
  end
end
