require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  it "有効なタグ内容の場合は保存されるか" do
    expect(build(:tag)).to be_valid
  end
end
