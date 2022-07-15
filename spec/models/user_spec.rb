require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  it "有効なユーザーデータの場合は保存されるか" do
  expect(build(:user)).to be_valid
  end
  
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    
    let (:post) { create(:post) }
    let!(:user) { build(:user) }
    
    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '10文字以下であること: 10文字は〇' do
        user.name = Faker::Lorem.characters(number:10)
        is_expected.to eq true
      end
      it '10文字以下であること: 11文字は×' do
        user.name = Faker::Lorem.characters(number:11)
        is_expected.to eq false
      end
    end
    context 'last_nameカラム' do
      it '空欄でないこと' do
        user.last_name = ''
        is_expected.to eq false
      end
    end
    context 'first_nameカラム' do
      it '空欄でないこと' do
        user.first_name = ''
        is_expected.to eq false
      end
    end
    context 'phone_numberカラム' do
      it '空欄でないこと' do
        user.phone_number = ''
        is_expected.to eq false
      end
    end
    describe 'アソシエーションのテスト' do
      context 'postモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:posts).macro).to eq :has_many
        end
      end
      context 'post_commentモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
        end
      end
      context 'Groupモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:groups).macro).to eq :has_many
        end
      end
      context 'group_usersモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:group_users).macro).to eq :has_many
        end
      end
    end
  end
  
  # context 'バリデーションのテスト' do
  #   it 'emailが入力されていない時は保存しない' do
  #   user = build(:user, email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include("を入力してください")
  #   end
  #   it 'last_nameが入力されていない時は保存しない' do
  #   user = build(:user, last_name: nil)
  #   user.valid?
  #   expect(user.errors[:last_name]).to include("を入力してください")
  #   end
  #   it 'first_nameが入力されていない時は保存しない' do
  #   user = build(:user, first_name: nil)
  #   user.valid?
  #   expect(user.errors[:first_name]).to include("を入力してください")
  #   end
  #   it 'passwordが入力されていない時は保存しない' do
  #   user = build(:user, password: nil)
  #   user.valid?
  #   expect(user.errors[:password]).to include("を入力してください")
  #   end
  #   it 'phone_numberが入力されていない時は保存しない' do
  #   user = build(:user, phone_number: nil)
  #   user.valid?
  #   expect(user.errors[:phone_number]).to include("を入力してください")
  #   end
  #   it "すでに存在しているemailは保存しない" do
  #     user = create(:user)
  #     another_user = build(:user, email: user.email)
  #     another_user.valid?
  #     expect(another_user.errors[:email]).to include("はすでに存在します")
  #   end
  # end
  
end
