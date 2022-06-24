class Post < ApplicationRecord
  #アソシエーション
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :group_users, through: :groups, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  
  #一枚の画像添付
  has_one_attached :post_image
  
  #バリデーション
  validates :title, length: { maximum: 20 }, presence: true
  validates :body, presence: true
  
  #投稿画像添付
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      post_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #ログインユーザーが投稿作成者か確認
  def is_owned_by?(user)
    self.user == user
  end
  
  #いいねがされているかの確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  #タグの保存
  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

     # 新しいタグを保存
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << post_tag
    end
  end

  # 検索方法分岐
  def self.search_for(search, word)
    if search == "perfect_match" #完全一致
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"#前方一致
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"#後方一致
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"#部分一致
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
