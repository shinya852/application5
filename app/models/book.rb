class Book < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :body, presence: true, length: { in: 1..200}
	#いいね
	 has_many :favorites, dependent: :destroy
	 #コメント機能
	 has_many :book_comments, dependent: :destroy

end
