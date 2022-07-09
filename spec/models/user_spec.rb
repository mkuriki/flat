require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なユーザーデータの場合は保存されるか" do
  expect(build(:user)).to be_valid
  end
  
  context 'バリデーションによって正しいデータ以外保存しない' do
    it 'emailが入力されていない時は保存しない' do
     user = build(:user, email: nil)
     user.valid?
     expect(user.errors[:email]).to include("を入力してください")
    end
    it 'last_nameが入力されていない時は保存しない' do
     user = build(:user, last_name: nil)
     user.valid?
     expect(user.errors[:last_name]).to include("を入力してください")
    end
    it 'first_nameが入力されていない時は保存しない' do
     user = build(:user, first_name: nil)
     user.valid?
     expect(user.errors[:first_name]).to include("を入力してください")
    end
    it 'passwordが入力されていない時は保存しない' do
     user = build(:user, password: nil)
     user.valid?
     expect(user.errors[:password]).to include("を入力してください")
    end
    it 'phone_numberが入力されていない時は保存しない' do
     user = build(:user, phone_number: nil)
     user.valid?
     expect(user.errors[:phone_number]).to include("を入力してください")
    end
  end
  
end
