class Tag < ApplicationRecord
    has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
    has_many :posts, through: :post_tags

  def self.search_posts_for(search, word)
    if search == "perfect_match"
      @tag = Tag.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @tag = Tag.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @tag = Tag.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
    return @tag.inject(init = []) {|result, tag| result + tag.posts}
  end
  
end
