require 'rails_helper'

RSpec.describe Group, type: :model do
  it "有効なグループ内容の場合は保存されるか" do
    expect(build(:group)).to be_valid
  end
  
  context 'バリデーションによっってによって正しいデータ以外保存しない' do
    it 'nameが21文字以上の時は保存しない' do
      group = build(:group, name: "012345678901234567890") 
      group.valid? 
      expect(group.errors[:name][0]).to include("は20文字以内で入力してください")
    end
  end
end
