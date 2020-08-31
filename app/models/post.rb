class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :description, :image, presence:true

  #def users
  #return User.where(id: post.user_id)
  #end
end
