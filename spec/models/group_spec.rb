require 'rails_helper'

RSpec.describe 'Groupモデルのテスト', type: :model do
  it "有効なグループ内容の場合は保存されるか" do
    expect(build(:group)).to be_valid
  end
  describe 'バリデーションのテスト' do
    subject { group.valid? }
    
    let(:post) { create(:post) }
    let!(:group) {build(:group, post_id: post.id)}
    
    context'nameカラム' do
      it '空欄でないこと' do
        group.name = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        group.name = Faker::Lorem.characters(number:20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        group.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        group.introduction = ''
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Group.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'usersモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:users).macro).to eq :has_many
      end
    end
    context 'group_usersモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:group_users).macro).to eq :has_many
      end
    end
  end
end
