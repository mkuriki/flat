# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Post, type: :model do
    it "有効な投稿内容の場合は保存されるか" do
    expect(build(:post)).to be_valid
  end
  
  context 'バリデーションによって正しいデータ以外保存しない' do
    it 'titleが入力されていないときは保存しない' do
      post = build(:post, title: nil)
      post.valid?
      expect(post.errors[:title]).to include("を入力してください")
    end
    it 'bodyが入力されていないときは保存しない' do
      post = build(:post, body: nil)
      post.valid?
      expect(post.errors[:body]).to include("を入力してください")
    end
    it 'dateが入力されていないときは保存しない' do
      post = build(:post, date: nil)
      post.valid?
      expect(post.errors[:date]).to include("を入力してください")
    end
    it 'titleが21文字以上の時は保存しない' do
      post = build(:post, title: "012345678901234567890") 
      post.valid? 
      expect(post.errors[:title][0]).to include("は20文字以内で入力してください")
    end

  end
end
