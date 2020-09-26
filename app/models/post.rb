class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_category_relationships
  has_many :categories, through: :post_category_relationships
  belongs_to :user
  has_one_attached :image
  validates :image, :alcohol, :amount, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :alcohol, numericality: {less_than: 100}

  def liked?(current_user)
    likes.where(user_id: current_user.id).exists?
  end

end
