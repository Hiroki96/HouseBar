class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:twitter]

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true, length: { maximum: 20 }
  validates :weight, numericality: {greater_than: 0, allow_blank: true}
  #validates :weight, :numericality => { :allow_blank => true }

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    user ||= User.create!(
        uid: auth.uid,
        provider: auth.provider,
        name: auth[:info][:name],
        weight: nil,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
    )

    user
  end

  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end

  def user_image(user_id)
    user = User.find!(user_id)
    if user.image.attached?
      image_tag user.image
    else
      image_tag 'default_avatar.jpg'
    end
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

end
