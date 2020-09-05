class Category < ApplicationRecord
  has_many :post_category_relationships
  has_many :posts, through: :post_category_relationships
end
