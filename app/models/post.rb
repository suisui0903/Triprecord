class Post < ApplicationRecord
	belongs_to :user
	attachment :image
	has_many :categories

	def self.search(search)
      if search
        Post.where(['name LIKE ?', "%#{search}%"])
      else
        Post.all
      end
    end

  has_many :favorites

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, :place, :image, :caption, presence: true

end
