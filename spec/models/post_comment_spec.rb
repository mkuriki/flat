require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  it "有効なコメント内容の場合は保存されるか" do
    expect(build(:post_comment)).to be_valid
  end
  context 'userモデルとの関係' do
    it 'N:1となっている' do
      expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
  context 'postモデルとの関係' do
    it 'N:1となっている' do
      expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
    end
  end
end
