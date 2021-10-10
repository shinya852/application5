class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction,length: { maximum: 50}

  has_many :favorites, dependent: :destroy#いいね機能


  # コメント機能
  has_many :book_comments, dependent: :destroy

  #以下follower機能
  #フォローする側
  has_many :relationships, foreign_key: :following_id
  #フォローしている人全員を持ってくる
  has_many :followings, through: :relationships, source: :follower


  #フォローされる側
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  #フォローしてくれている人を全部持ってくる
  has_many :followers, through: :reverse_of_relationships, source: :following

  def already_favorited?(book)
      self.favorites.exists?(book_id: book.id)
  end

  def already_following?(user)
      self.followings.exists?(id: user.id)
  end

end