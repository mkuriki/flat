# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
    it "有効な投稿内容の場合は保存されるか" do
    expect(build(:post)).to be_valid
    end
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        post.title = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        post.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        is_expected.to eq false
      end
    end
    context 'dateカラム' do
      it '空欄でないこと' do
        post.body = ''
        is_expected.to eq false
      end
    end
    describe 'アソシエーションのテスト' do
      context 'Userモデルとの関係' do
        it 'N:1となっている' do
          expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end
      context 'post_commentモデルとの関係' do
        it '1:Nとなっている' do
          expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
        end
      end
      context 'Groupモデルとの関係' do
        it '1:Nとなっている' do
          expect(Post.reflect_on_association(:groups).macro).to eq :has_many
        end
      end
      context 'group_usersモデルとの関係' do
        it '1:Nとなっている' do
          expect(Post.reflect_on_association(:group_users).macro).to eq :has_many
        end
      end
    end
  end
end