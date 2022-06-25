class Tag < ApplicationRecord
  #アソシエーション
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  # 検索方法分岐
  def self.search_posts_for(search, word)
    if search == "perfect_match" #完全一致
      @tag = Tag.where("name LIKE?", "#{word}")
    elsif search == "forward_match"#前方一致
      @tag = Tag.where("name LIKE?","#{word}%")
    elsif search == "backward_match"#後方一致
      @tag = Tag.where("name LIKE?","%#{word}")
    elsif search == "partial_match"#部分一致
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
    return @tag.inject(init = []) {|result, tag| result + tag.posts}
  end
end
